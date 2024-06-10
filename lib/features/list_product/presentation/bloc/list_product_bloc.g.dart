// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_product_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ListProductStateCWProxy {
  ListProductState page(int page);

  ListProductState listProduct(List<Product> listProduct);

  ListProductState listProductColor(List<ProductColor> listProductColor);

  ListProductState status(GetProductStatus status);

  ListProductState canLoadMore(bool? canLoadMore);

  ListProductState productHasError(int? productHasError);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ListProductState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ListProductState(...).copyWith(id: 12, name: "My name")
  /// ````
  ListProductState call({
    int? page,
    List<Product>? listProduct,
    List<ProductColor>? listProductColor,
    GetProductStatus? status,
    bool? canLoadMore,
    int? productHasError,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfListProductState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfListProductState.copyWith.fieldName(...)`
class _$ListProductStateCWProxyImpl implements _$ListProductStateCWProxy {
  const _$ListProductStateCWProxyImpl(this._value);

  final ListProductState _value;

  @override
  ListProductState page(int page) => this(page: page);

  @override
  ListProductState listProduct(List<Product> listProduct) =>
      this(listProduct: listProduct);

  @override
  ListProductState listProductColor(List<ProductColor> listProductColor) =>
      this(listProductColor: listProductColor);

  @override
  ListProductState status(GetProductStatus status) => this(status: status);

  @override
  ListProductState canLoadMore(bool? canLoadMore) =>
      this(canLoadMore: canLoadMore);

  @override
  ListProductState productHasError(int? productHasError) =>
      this(productHasError: productHasError);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ListProductState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ListProductState(...).copyWith(id: 12, name: "My name")
  /// ````
  ListProductState call({
    Object? page = const $CopyWithPlaceholder(),
    Object? listProduct = const $CopyWithPlaceholder(),
    Object? listProductColor = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? canLoadMore = const $CopyWithPlaceholder(),
    Object? productHasError = const $CopyWithPlaceholder(),
  }) {
    return ListProductState(
      page: page == const $CopyWithPlaceholder() || page == null
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      listProduct:
          listProduct == const $CopyWithPlaceholder() || listProduct == null
              ? _value.listProduct
              // ignore: cast_nullable_to_non_nullable
              : listProduct as List<Product>,
      listProductColor: listProductColor == const $CopyWithPlaceholder() ||
              listProductColor == null
          ? _value.listProductColor
          // ignore: cast_nullable_to_non_nullable
          : listProductColor as List<ProductColor>,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as GetProductStatus,
      canLoadMore: canLoadMore == const $CopyWithPlaceholder()
          ? _value.canLoadMore
          // ignore: cast_nullable_to_non_nullable
          : canLoadMore as bool?,
      productHasError: productHasError == const $CopyWithPlaceholder()
          ? _value.productHasError
          // ignore: cast_nullable_to_non_nullable
          : productHasError as int?,
    );
  }
}

extension $ListProductStateCopyWith on ListProductState {
  /// Returns a callable class that can be used as follows: `instanceOfListProductState.copyWith(...)` or like so:`instanceOfListProductState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ListProductStateCWProxy get copyWith => _$ListProductStateCWProxyImpl(this);
}
