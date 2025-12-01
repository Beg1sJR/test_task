import 'package:dio/dio.dart';
import 'package:test_task/features/products/data/model/products.dart';

class ProductsData {
  final Dio dio;

  ProductsData({required this.dio});

  Future<List<ProductModel>> getAllProducts() async {
    final response = await dio.get('http://10.0.2.2:8080/api/public/products');
    final data = response.data['products'] as List;
    return data.map((e) => ProductModel.fromMap(e)).toList();
  }

  Future<ProductModel> createProduct(
    String token,
    Map<String, dynamic> data,
  ) async {
    final response = await dio.post(
      'http://10.0.2.2:8080/api/products',
      data: data,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return ProductModel.fromMap(response.data['product']);
  }
}
