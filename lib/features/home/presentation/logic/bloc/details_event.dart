part of 'details_bloc.dart';

sealed class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadProductDetails extends DetailsEvent {
  final int id;

  const LoadProductDetails(this.id);

  @override
  List<Object> get props => [id];
}
