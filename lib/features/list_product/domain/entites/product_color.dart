import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:base_1/core/config/app_constatns.dart';
import 'package:base_1/features/list_product/data/models/product_color/product_color_model.dart';

class ProductColor extends Equatable {
  const ProductColor({
    required this.id,
    this.name,
    this.hexColor,
  });

  final int id;
  final String? name;
  final Color? hexColor;

  factory ProductColor.toEntity(ProductColorModel model) {
    return ProductColor(
      id: model.id ?? 0,
      name: model.name,
      hexColor: Constants.colorStringToColor.entries
          .firstWhereOrNull(
            (element) => element.key == model.name?.toLowerCase(),
          )
          ?.value,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        hexColor,
      ];
}
