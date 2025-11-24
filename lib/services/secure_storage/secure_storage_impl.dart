import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_task/services/secure_storage/secure_storage_repository.dart';

final class SecureStorageImpl implements SecureStorageRepository {
  SecureStorageImpl({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;

  static const _tokenKey = 'token_key';

  @override
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  @override
  Future<String> getToken() async {
    return await _secureStorage.read(key: _tokenKey) ?? '';
  }

  @override
  Future<void> setToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }
}
