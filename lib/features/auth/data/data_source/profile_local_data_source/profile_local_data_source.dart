import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/features/auth/data/model/login/login.dart';

class ProfileLocalDataSource {
  ProfileLocalDataSource({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const _key = "user_profile";

  Future<void> setUser(UserModel user) async {
    _sharedPreferences.setString(_key, jsonEncode(user.toMap()));
  }

  Future<UserModel> getUser() async {
    final raw = _sharedPreferences.getString(_key);

    return UserModel.fromMap(jsonDecode(raw ?? ''));
  }

  Future<void> clearUser() async {
    await _sharedPreferences.remove(_key);
  }
}
