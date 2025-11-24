import 'package:test_task/features/products/data/data_source/products.dart';
import 'package:test_task/features/products/data/model/products.dart';
import 'package:test_task/features/products/domain/repository/products.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsData productsData;

  ProductsRepositoryImpl({required this.productsData});

  @override
  Future<ProductModel> createProduct(
    String token,
    Map<String, dynamic> data,
  ) async {
    return await productsData.createProduct(token, data);
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    return await productsData.getAllProducts();
  }
}
