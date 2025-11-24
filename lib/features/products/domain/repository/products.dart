import 'package:test_task/features/products/data/model/products.dart';

abstract interface class ProductsRepository {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> createProduct(String token, Map<String, dynamic> data);
}
