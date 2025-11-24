// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/auth/domain/repository/login.dart';
import 'package:test_task/features/profile/domain/repository/profile/profile.dart';
import 'package:test_task/services/secure_storage/secure_storage_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final ProfileRepository profileRepository;
  final SecureStorageRepository secureStorageRepository;

  AuthBloc({
    required this.profileRepository,
    required this.secureStorageRepository,
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);

    on<RegisterEvent>(_onRegisterEvent);

    on<LogoutEvent>(_onLogoutEvent);

    on<CheckToken>(_onCheckToken);
  }

  FutureOr<void> _onCheckToken(event, emit) async {
    final token = await secureStorageRepository.getToken();
    log('checktokenbloc $token');
    if (token.isNotEmpty) {
      log('Токен получен');
      emit(TokenAuthenticated(token: token));
    } else {
      log('Токена нет');
      emit(TokenNotAuthenticated());
    }
  }

  FutureOr<void> _onLogoutEvent(event, emit) async {
    emit(AuthLoading());

    try {
      await secureStorageRepository.deleteToken();

      await profileRepository.clearUser();

      emit(TokenNotAuthenticated());
    } catch (e) {
      emit(AuthFailure(message: 'Ошибка при выходе: $e'));
    }
  }

  FutureOr<void> _onRegisterEvent(event, emit) async {
    emit(AuthLoading());
    try {
      final registerModel = await authRepository.register(
        data: {
          'email': event.username,
          'password': event.password,
          'first_name': event.firstName,
          'last_name': event.lastName,
        },
      );
      final loginModel = await authRepository.login(
        data: {'email': event.username, 'password': event.password},
      );
      log(
        'Register data: ${{'email': event.username, 'password': event.password, 'first_name': event.firstName, 'last_name': event.lastName}}',
      );
      await secureStorageRepository.setToken(loginModel.token ?? '');

      if (loginModel.user != null) {
        await profileRepository.setUser(loginModel.user!);
      } else {
        emit(AuthFailure(message: 'Нет данных пользователя'));
        return;
      }

      emit(AuthSuccess(loginModel: loginModel));
    } on DioException catch (e) {
      String message = 'Ошибка входа';
      if (e.response?.statusCode == 500) {
        message = 'Неправильный email или пароль';
      } else if (e.type == DioExceptionType.connectionTimeout) {
        message = 'Проблемы с соединением';
      }
      emit(AuthFailure(message: message));
    } catch (e) {
      emit(AuthFailure(message: 'Что-то пошло не так'));
    }
  }

  FutureOr<void> _onLoginEvent(event, emit) async {
    emit(AuthLoading());
    try {
      final loginModel = await authRepository.login(
        data: {'email': event.username, 'password': event.password},
      );
      await secureStorageRepository.setToken(loginModel.token ?? '');

      if (loginModel.user != null) {
        await profileRepository.setUser(loginModel.user!);
      } else {
        emit(AuthFailure(message: 'Нет данных пользователя'));
        return;
      }

      emit(AuthSuccess(loginModel: loginModel));
    } on DioException catch (e) {
      String message = 'Ошибка входа';
      if (e.response?.statusCode == 500) {
        message = 'Неправильный email или пароль';
      } else if (e.type == DioExceptionType.connectionTimeout) {
        message = 'Проблемы с соединением';
      }
      emit(AuthFailure(message: message));
    } catch (e) {
      emit(AuthFailure(message: 'Что-то пошло не так'));
    }
  }
}
