// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appRouterService)
const appRouterServiceProvider = AppRouterServiceProvider._();

final class AppRouterServiceProvider
    extends
        $FunctionalProvider<
          AppRouterService,
          AppRouterService,
          AppRouterService
        >
    with $Provider<AppRouterService> {
  const AppRouterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterServiceHash();

  @$internal
  @override
  $ProviderElement<AppRouterService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppRouterService create(Ref ref) {
    return appRouterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRouterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRouterService>(value),
    );
  }
}

String _$appRouterServiceHash() => r'09c107b6eb843c99c80ce6abeaefd3ccb71a087e';
