import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/products/data/model/products.dart';
import 'package:test_task/features/products/domain/repository/products.dart';
import 'package:test_task/services/secure_storage/secure_storage_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository productsRepository;
  final SecureStorageRepository secureStorageRepository;

  ProductsBloc({
    required this.productsRepository,
    required this.secureStorageRepository,
  }) : super(ProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddProduct>(_onAddProduct);
  }

  FutureOr<void> _onAddProduct(
    AddProduct event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final token = await secureStorageRepository.getToken();

      await productsRepository.createProduct(token, event.product.toMap());
      final products = await productsRepository.getAllProducts();
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }

  FutureOr<void> _onLoadProducts(event, emit) async {
    emit(ProductsLoading());
    try {
      final products = await productsRepository.getAllProducts();
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }
}
