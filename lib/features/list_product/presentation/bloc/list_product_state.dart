part of 'list_product_bloc.dart';

@CopyWith()
class ListProductState extends Equatable {
  final int page;
  final List<Product> listProduct;
  final List<ProductColor> listProductColor;
  final GetProductStatus status;
  final bool? canLoadMore;
  final int? productHasError;

  const ListProductState({
    this.page = 1,
    this.listProduct = const <Product>[],
    this.listProductColor = const <ProductColor>[],
    this.status = GetProductStatus.initial,
    this.canLoadMore,
    this.productHasError,
  });

  @override
  List<Object?> get props => [
        page,
        listProduct,
        status,
        canLoadMore,
        productHasError,
      ];
}

enum GetProductStatus { initial, success, error, editSuccess }
