import 'package:test_task/features/auth/data/data_source/auth.dart';
import 'package:test_task/features/auth/data/model/login/login.dart';
import 'package:test_task/features/auth/data/model/register/register.dart';
import 'package:test_task/features/auth/domain/repository/login.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthData authData;

  AuthRepositoryImpl({required this.authData});

  @override
  Future<LoginModel> login({required Map<String, dynamic> data}) async {
    return await authData.login(data: data);
  }

  @override
  Future<RegisterModel> register({required Map<String, dynamic> data}) async {
    return await authData.register(data: data);
  }
}
