abstract interface class SecureStorageRepository {
  Future<void> setToken(String token);
  Future<String> getToken();
  Future<void> deleteToken();
}
