// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_storage_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for TokenStorageService

@ProviderFor(tokenStorageService)
const tokenStorageServiceProvider = TokenStorageServiceProvider._();

/// Provider for TokenStorageService

final class TokenStorageServiceProvider
    extends
        $FunctionalProvider<
          TokenStorageService,
          TokenStorageService,
          TokenStorageService
        >
    with $Provider<TokenStorageService> {
  /// Provider for TokenStorageService
  const TokenStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenStorageServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenStorageServiceHash();

  @$internal
  @override
  $ProviderElement<TokenStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TokenStorageService create(Ref ref) {
    return tokenStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenStorageService>(value),
    );
  }
}

String _$tokenStorageServiceHash() =>
    r'97a96addaae119aa476370b03d33a0001c87476b';
