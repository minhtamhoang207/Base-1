import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:base_1/features/list_product/data/data_source/remote/api/product_api.dart';
import 'package:base_1/features/list_product/domain/entites/product.dart';
import 'package:base_1/features/list_product/domain/entites/product_color.dart';
import 'package:base_1/features/list_product/domain/repositories/product_repository.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._productApi);
  final ProductApi _productApi;

  @override
  Future<Either<dynamic, List<Product>>> getProducts({
    required int page,
    required int limit,
  }) async {
    try {
      final res = await _productApi.getProducts(page: page, limit: limit);
      return right(res.map((e) => Product.toEntity(e)).toList());
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  @override
  Future<Either<dynamic, List<ProductColor>>> getProductColors() async {
    try {
      final res = await _productApi.getProductColors();
      return right(res.map((e) => ProductColor.toEntity(e)).toList());
    } on DioError catch (exception) {
      return left(exception);
    }
  }
}
