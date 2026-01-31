import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/secure_storage/secure_storage_keys.dart';
import '../../../../utils/secure_storage/secure_storage_service.dart';

part 'token_storage_service.g.dart';

/// Secure storage service for authentication tokens
/// Uses SecureStorageService to securely store sensitive data
class TokenStorageService {
  final SecureStorageService _storage;

  TokenStorageService(this._storage);

  /// Stores authentication tokens and user ID
  Future<void> storeTokens({
    required String accessToken,
    required String refreshToken,
    required String userId,
    String? firebaseUid,
    String? firebaseToken,
  }) async {
    debugLog(DebugTags.authTokenFetch, 'Storing tokens for user: $userId');
    final writes = <Future<void>>[
      _storage.write(SecureStorageKeys.accessToken, accessToken),
      _storage.write(SecureStorageKeys.refreshToken, refreshToken),
      _storage.write(SecureStorageKeys.userId, userId),
      _storage.write(SecureStorageKeys.firebaseUid, firebaseUid ?? userId),
    ];
    if (firebaseToken != null && firebaseToken.isNotEmpty) {
      writes.add(
        _storage.write(SecureStorageKeys.firebaseToken, firebaseToken),
      );
    }
    await Future.wait(writes);
  }

  /// Retrieves the access token
  Future<String?> getAccessToken() async {
    try {
      return await _storage.read(SecureStorageKeys.accessToken);
    } catch (_) {
      return null;
    }
  }

  /// Retrieves the refresh token
  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(SecureStorageKeys.refreshToken);
    } catch (_) {
      return null;
    }
  }

  /// Retrieves the user ID
  Future<String?> getUserId() async {
    try {
      return await _storage.read(SecureStorageKeys.userId);
    } catch (_) {
      return null;
    }
  }

  /// Retrieves the Firebase UID (falls back to user_id if unset)
  Future<String?> getFirebaseUid() async {
    try {
      return await _storage.read(SecureStorageKeys.firebaseUid);
    } catch (_) {
      return null;
    }
  }

  /// Retrieves the Firebase custom token (if available)
  Future<String?> getFirebaseToken() async {
    try {
      return await _storage.read(SecureStorageKeys.firebaseToken);
    } catch (_) {
      return null;
    }
  }

  /// Checks if user is authenticated (has valid access token)
  Future<bool> isAuthenticated() async {
    final token = await getAccessToken();
    final hasToken = token != null && token.isNotEmpty;
    debugLog(DebugTags.authTokenFetch, 'Is authenticated: $hasToken');
    return hasToken;
  }

  /// Clears all stored tokens and user data
  Future<void> clearTokens() async {
    debugLog(DebugTags.authTokenFetch, 'Clearing all auth tokens');
    await Future.wait([
      _storage.delete(SecureStorageKeys.accessToken),
      _storage.delete(SecureStorageKeys.refreshToken),
      _storage.delete(SecureStorageKeys.userId),
      _storage.delete(SecureStorageKeys.firebaseUid),
      _storage.delete(SecureStorageKeys.firebaseToken),
    ]);
  }

  /// Clears all secure storage (use with caution)
  Future<void> clearAll() async {
    debugLog(DebugTags.authTokenFetch, 'CRITICAL: Clearing ALL secure storage');
    await _storage.deleteAll();
  }
}

/// Provider for TokenStorageService
@Riverpod(keepAlive: true)
TokenStorageService tokenStorageService(Ref ref) {
  final storage = ref.watch(secureStorageServiceProvider);
  return TokenStorageService(storage);
}
