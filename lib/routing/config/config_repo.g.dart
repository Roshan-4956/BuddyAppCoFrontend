// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(configRepo)
const configRepoProvider = ConfigRepoProvider._();

final class ConfigRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<ConfigModel, ConfigParams>,
          RiverpodAPI<ConfigModel, ConfigParams>,
          RiverpodAPI<ConfigModel, ConfigParams>
        >
    with $Provider<RiverpodAPI<ConfigModel, ConfigParams>> {
  const ConfigRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'configRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$configRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<ConfigModel, ConfigParams>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RiverpodAPI<ConfigModel, ConfigParams> create(Ref ref) {
    return configRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RiverpodAPI<ConfigModel, ConfigParams> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<RiverpodAPI<ConfigModel, ConfigParams>>(value),
    );
  }
}

String _$configRepoHash() => r'a38fc625b5c65915151caa2453cccd4d06ff84c6';
