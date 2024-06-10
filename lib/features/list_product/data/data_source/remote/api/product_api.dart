import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:base_1/core/config/endpoint_constants.dart';
import 'package:base_1/features/list_product/data/models/product/product_model.dart';
import 'package:base_1/features/list_product/data/models/product_color/product_color_model.dart';

part 'product_api.g.dart';

@lazySingleton
@RestApi()
abstract class ProductApi {
  @factoryMethod
  factory ProductApi(Dio dio) = _ProductApi;

  @GET(EndpointConstants.getProducts)
  Future<List<ProductModel>> getProducts({
    @Query("page") required int page,
    @Query("limit") required int limit,
  });

  @GET(EndpointConstants.getProductColors)
  Future<List<ProductColorModel>> getProductColors();
}
