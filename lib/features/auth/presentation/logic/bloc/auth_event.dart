import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterEvent({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [username, password, firstName, lastName];
}

class LogoutEvent extends AuthEvent {}

class CheckToken extends AuthEvent {}
