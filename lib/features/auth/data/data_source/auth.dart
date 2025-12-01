import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:test_task/features/auth/data/model/login/login.dart';
import 'package:test_task/features/auth/data/model/register/register.dart';

class AuthData {
  final Dio dio;

  AuthData({required this.dio});

  Future<LoginModel> login({required Map<String, dynamic> data}) async {
    final responseLogin = await dio.post(
      'http://10.0.2.2:8080/auth/login',
      data: data,
    );

    log(responseLogin.data.toString());
    return LoginModel.fromMap(responseLogin.data);
  }

  Future<RegisterModel> register({required Map<String, dynamic> data}) async {
    final responseRegister = await dio.post(
      'http://10.0.2.2:8080/auth/register',
      data: data,
    );
    log(responseRegister.data.toString());

    return RegisterModel.fromMap(responseRegister.data);
  }
}
