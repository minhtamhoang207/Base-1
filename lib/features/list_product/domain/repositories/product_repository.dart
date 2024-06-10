import 'package:dartz/dartz.dart';
import 'package:base_1/features/list_product/domain/entites/product.dart';
import 'package:base_1/features/list_product/domain/entites/product_color.dart';

abstract class ProductRepository {
  Future<Either<dynamic, List<Product>>> getProducts({
    required int page,
    required int limit,
  });
  Future<Either<dynamic, List<ProductColor>>> getProductColors();
}
