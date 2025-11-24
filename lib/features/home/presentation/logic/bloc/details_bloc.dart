import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/home/data/model/products.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<LoadProductDetails>(_onLoadProductDetails);
  }

  FutureOr<void> _onLoadProductDetails(event, emit) {
    try {
      final product = mockProducts.firstWhere((p) => p.id == event.id);

      emit(DetailsLoaded(product: product));
    } catch (e) {
      emit(DetailsError('Product not found'));
    }
  }
}
