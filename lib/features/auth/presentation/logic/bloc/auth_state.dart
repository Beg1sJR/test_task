import 'package:equatable/equatable.dart';
import 'package:test_task/features/auth/data/model/login/login.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final LoginModel loginModel;

  const AuthSuccess({required this.loginModel});

  @override
  List<Object?> get props => [loginModel];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TokenAuthenticated extends AuthState {
  final String token;

  const TokenAuthenticated({required this.token});
  @override
  List<Object?> get props => [token];
}

final class TokenNotAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

final class TokenLoading extends AuthState {
  @override
  List<Object?> get props => [];
}
