import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Create a private constructor (Singleton Pattern)
  SecureStorage._privateConstructor();
  static final SecureStorage instance = SecureStorage._privateConstructor();

  // Create storage instance
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Save a value in secure storage
  Future<void> writeSecureData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read a value from secure storage
  Future<String?> readSecureData(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a specific key from secure storage
  Future<void> deleteSecureData(String key) async {
    await _storage.delete(key: key);
  }

  /// Delete all keys from secure storage
  Future<void> deleteAllSecureData() async {
    await _storage.deleteAll();
  }

  /// Check if a key exists in secure storage
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }
}

class SecureStorageKeys {
  static const String sid_cookie = 'sid_cookie';
}
