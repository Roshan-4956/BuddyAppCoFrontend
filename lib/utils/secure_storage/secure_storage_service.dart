import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../logger.dart';

part 'secure_storage_service.g.dart';

/// A service providing secure storage operations using FlutterSecureStorage.
class SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  /// Constructs a new [SecureStorageService] instance.
  SecureStorageService() : _secureStorage = FlutterSecureStorage();

  /// Checks if the secure storage contains a value for [key].
  Future<bool> hasKey(String key) async {
    debugLog(DebugTags.secureStorage, 'Checking key: $key');
    return await _secureStorage.read(key: key) != null;
  }

  /// Reads the value associated with [key] from secure storage.
  /// Throws an [Exception] if the key is not found.
  Future<String> read(String key) async {
    debugLog(DebugTags.secureStorage, 'Reading key: $key');
    String? res = await _secureStorage.read(key: key);
    if (res == null) {
      debugLog(DebugTags.secureStorage, 'Not found key: $key');
      throw Exception('No value was stored for $key');
    }

    return res;
  }

  /// Writes the [value] to secure storage under the provided [key].
  Future<void> write(String key, String value) async {
    debugLog(DebugTags.secureStorage, 'Writing key: $key');
    await _secureStorage.write(key: key, value: value);
  }

  /// Deletes the value associated with [key] from secure storage.
  Future<void> delete(String key) async {
    debugLog(DebugTags.secureStorage, 'Deleting key: $key');
    await _secureStorage.delete(key: key);
  }

  /// Deletes all values from secure storage.
  Future<void> deleteAll() async {
    debugLog(DebugTags.secureStorage, 'Deleting all keys');
    await _secureStorage.deleteAll();
  }
}

/// Provides a global instance of [SecureStorageService] that remains alive.
@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(Ref ref) {
  return SecureStorageService();
}
