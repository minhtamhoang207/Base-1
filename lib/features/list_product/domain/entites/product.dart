import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:base_1/features/list_product/data/models/product/product_model.dart';
import 'package:base_1/features/list_product/domain/entites/product_color.dart';

part 'product.g.dart';

@CopyWith()
class Product extends Equatable {
  const Product({
    this.id,
    required this.name,
    required this.sku,
    this.errorDescription,
    this.image,
    this.color,
    this.productColor,
    this.hexColor,
  });

  final int? id;
  final String name;
  final String sku;
  final String? errorDescription;
  final String? image;
  final int? color;
  final ProductColor? productColor;
  final Color? hexColor;

  factory Product.toEntity(ProductModel model) {
    return Product(
      id: model.id,
      name: model.name ?? '',
      sku: model.sku ?? '',
      errorDescription: model.errorDescription,
      image: model.image,
      color: model.color,
      productColor: null,
      hexColor: null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        sku,
        errorDescription,
        image,
        color,
        hexColor,
      ];
}
