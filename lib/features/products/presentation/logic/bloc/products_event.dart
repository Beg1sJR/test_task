part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductsEvent {}

class AddProduct extends ProductsEvent {
  final ProductModel product;

  const AddProduct({required this.product});

  @override
  List<Object> get props => [product];
}
