import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:base_1/core/config/app_constatns.dart';
import 'package:base_1/core/extensions/string_extension.dart';
import 'package:base_1/features/list_product/domain/entites/product.dart';
import 'package:base_1/features/list_product/domain/entites/product_color.dart';
import 'package:base_1/features/list_product/domain/repositories/product_repository.dart';

part 'list_product_bloc.g.dart';
part 'list_product_event.dart';
part 'list_product_state.dart';

class ListProductBloc extends Bloc<ProductEvent, ListProductState> {
  final ProductRepository _productRepository;

  ListProductBloc(this._productRepository) : super(const ListProductState()) {
    on<GetProductEvent>(_onGetProduct);
    on<LoadMoreProductEvent>(_onLoadMoreProduct);
    on<GetColorEvent>(_onGetColor);
    on<EditProductEvent>(_onEditProduct);
    on<OnTapSubmitEvent>(_onTapSubmit);
  }

  FutureOr<void> _onGetProduct(
    GetProductEvent event,
    Emitter<ListProductState> emit,
  ) async {
    emit(state.copyWith(status: GetProductStatus.initial));

    final response = await Future.wait([
      _productRepository.getProductColors(),
      _productRepository.getProducts(
        page: event.page,
        limit: Constants.pageLimit,
      ),
    ]);

    response[1].fold((error) {
      emit(
        state.copyWith(
          status: GetProductStatus.error,
          canLoadMore: false,
        ),
      );
    }, (data) {
      final listColor = response[0].foldRight<List<ProductColor>>(
        [],
        (colorData, _) => colorData as List<ProductColor>,
      );
      final listPaginatedProduct = _getItemsForPage(
        page: event.page,
        productList: (data as List<Product>).map((Product e) {
          final color = listColor.firstWhereOrNull(
            (element) => element.id == e.color,
          );
          return e.copyWith(
            productColor: color,
            hexColor: color?.hexColor,
          );
        }).toList(),
      );
      emit(
        state.copyWith(
          listProduct: event.page == 1
              ? listPaginatedProduct
              : [
                  ...state.listProduct,
                  ...listPaginatedProduct,
                ],
          listProductColor: listColor,
          status: GetProductStatus.success,
          canLoadMore: event.page < _calculateMaxPage(data),
          page: event.page,
        ),
      );
    });
  }

  FutureOr<void> _onLoadMoreProduct(
    LoadMoreProductEvent event,
    Emitter<ListProductState> emit,
  ) async {
    add(GetProductEvent(page: state.page + 1));
  }

  FutureOr<void> _onGetColor(
    GetColorEvent event,
    Emitter<ListProductState> emit,
  ) async {
    emit(state.copyWith(status: GetProductStatus.initial));
    final response = await _productRepository.getProductColors();
    response.fold(
      (error) => emit(
        state.copyWith(
          status: GetProductStatus.error,
          canLoadMore: false,
        ),
      ),
      (data) => emit(
        state.copyWith(
          status: GetProductStatus.success,
          canLoadMore: true,
        ),
      ),
    );
  }

  FutureOr<void> _onEditProduct(
    EditProductEvent event,
    Emitter<ListProductState> emit,
  ) async {
    final newList = state.listProduct.map((e) {
      if (e.id == event.product.id) {
        return event.product;
      }
      return e;
    }).toList();

    emit(
      state.copyWith(
        listProduct: newList,
        status: GetProductStatus.editSuccess,
      ),
    );
  }

  // This function exists because the API doesn't have pagination.
  // I have tried to pass the page and limit parameters, but it doesn't work.
  List<Product> _getItemsForPage({
    required List<Product> productList,
    required int page,
  }) {
    // Calculate start index based on the page number
    int startIndex = (page - 1) * 10;

    // Ensure startIndex does not exceed the length of the list
    if (startIndex >= productList.length) {
      return []; // Return an empty list if startIndex is out of range
    }

    int endIndex = startIndex + 9; // 10 items per page

    // Ensure endIndex does not exceed the length of the list
    endIndex =
        endIndex < productList.length ? endIndex : productList.length - 1;

    // Retrieve sublist based on start and end index
    return productList.sublist(startIndex, endIndex + 1);
  }

  int _calculateMaxPage(List items) {
    return (items.length / Constants.pageLimit).ceil();
  }

  int findIndexEmptyNameOrSku() {
    return state.listProduct.indexWhere(
      (element) => element.name.isNullOrEmpty() || element.sku.isNullOrEmpty(),
    );
  }

  int? findIdEmptyNameOrSku() {
    return state.listProduct
        .firstWhereOrNull(
          (element) =>
              element.name.isNullOrEmpty() || element.sku.isNullOrEmpty(),
        )
        ?.id;
  }

  FutureOr<void> _onTapSubmit(
    OnTapSubmitEvent event,
    Emitter<ListProductState> emit,
  ) async {
    emit(
      state.copyWith(
        productHasError: findIdEmptyNameOrSku(),
      ),
    );
  }
}
