import 'package:test_task/features/auth/data/model/login/login.dart';

abstract interface class ProfileRepository {
  Future<UserModel> getUser();
  Future<void> setUser(UserModel user);
  Future<void> clearUser();
}
