import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_color_model.freezed.dart';
part 'product_color_model.g.dart';

@freezed
class ProductColorModel with _$ProductColorModel {
  const factory ProductColorModel({
    int? id,
    String? name,
  }) = _ProductColorModel;

  factory ProductColorModel.fromJson(Map<String, dynamic> json) =>
      _$ProductColorModelFromJson(json);
}
