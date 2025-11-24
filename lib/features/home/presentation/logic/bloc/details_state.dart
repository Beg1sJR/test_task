part of 'details_bloc.dart';

sealed class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

final class DetailsInitial extends DetailsState {}

final class DetailsLoaded extends DetailsState {
  final Product product;

  const DetailsLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

class DetailsError extends DetailsState {
  final String message;
  const DetailsError(this.message);

  @override
  List<Object> get props => [message];
}
