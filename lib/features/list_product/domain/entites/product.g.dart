// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductCWProxy {
  Product id(int? id);

  Product name(String name);

  Product sku(String sku);

  Product errorDescription(String? errorDescription);

  Product image(String? image);

  Product color(int? color);

  Product productColor(ProductColor? productColor);

  Product hexColor(Color? hexColor);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Product(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Product(...).copyWith(id: 12, name: "My name")
  /// ````
  Product call({
    int? id,
    String? name,
    String? sku,
    String? errorDescription,
    String? image,
    int? color,
    ProductColor? productColor,
    Color? hexColor,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProduct.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProduct.copyWith.fieldName(...)`
class _$ProductCWProxyImpl implements _$ProductCWProxy {
  const _$ProductCWProxyImpl(this._value);

  final Product _value;

  @override
  Product id(int? id) => this(id: id);

  @override
  Product name(String name) => this(name: name);

  @override
  Product sku(String sku) => this(sku: sku);

  @override
  Product errorDescription(String? errorDescription) =>
      this(errorDescription: errorDescription);

  @override
  Product image(String? image) => this(image: image);

  @override
  Product color(int? color) => this(color: color);

  @override
  Product productColor(ProductColor? productColor) =>
      this(productColor: productColor);

  @override
  Product hexColor(Color? hexColor) => this(hexColor: hexColor);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Product(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Product(...).copyWith(id: 12, name: "My name")
  /// ````
  Product call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sku = const $CopyWithPlaceholder(),
    Object? errorDescription = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? color = const $CopyWithPlaceholder(),
    Object? productColor = const $CopyWithPlaceholder(),
    Object? hexColor = const $CopyWithPlaceholder(),
  }) {
    return Product(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      sku: sku == const $CopyWithPlaceholder() || sku == null
          ? _value.sku
          // ignore: cast_nullable_to_non_nullable
          : sku as String,
      errorDescription: errorDescription == const $CopyWithPlaceholder()
          ? _value.errorDescription
          // ignore: cast_nullable_to_non_nullable
          : errorDescription as String?,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
      color: color == const $CopyWithPlaceholder()
          ? _value.color
          // ignore: cast_nullable_to_non_nullable
          : color as int?,
      productColor: productColor == const $CopyWithPlaceholder()
          ? _value.productColor
          // ignore: cast_nullable_to_non_nullable
          : productColor as ProductColor?,
      hexColor: hexColor == const $CopyWithPlaceholder()
          ? _value.hexColor
          // ignore: cast_nullable_to_non_nullable
          : hexColor as Color?,
    );
  }
}

extension $ProductCopyWith on Product {
  /// Returns a callable class that can be used as follows: `instanceOfProduct.copyWith(...)` or like so:`instanceOfProduct.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductCWProxy get copyWith => _$ProductCWProxyImpl(this);
}
