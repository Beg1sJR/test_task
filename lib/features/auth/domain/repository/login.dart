import 'package:test_task/features/auth/data/model/login/login.dart';
import 'package:test_task/features/auth/data/model/register/register.dart';

abstract interface class AuthRepository {
  Future<LoginModel> login({required Map<String, dynamic> data});
  Future<RegisterModel> register({required Map<String, dynamic> data});
}
