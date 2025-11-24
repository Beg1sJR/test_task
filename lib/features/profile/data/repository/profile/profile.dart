import 'dart:developer';

import 'package:test_task/features/auth/data/data_source/profile_local_data_source/profile_local_data_source.dart';
import 'package:test_task/features/auth/data/model/login/login.dart';
import 'package:test_task/features/profile/domain/repository/profile/profile.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource local;

  ProfileRepositoryImpl({required this.local});

  @override
  Future<UserModel> getUser() async {
    return await local.getUser();
  }

  @override
  Future<void> setUser(UserModel user) async {
    await local.setUser(user);
  }

  @override
  Future<void> clearUser() async {
    await local.clearUser();

    log('data cleared');
  }
}
