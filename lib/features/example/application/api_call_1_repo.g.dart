// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_call_1_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apiCall1Repo)
const apiCall1RepoProvider = ApiCall1RepoProvider._();

final class ApiCall1RepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<ApiCall1Model, ApiCall1Params>,
          RiverpodAPI<ApiCall1Model, ApiCall1Params>,
          RiverpodAPI<ApiCall1Model, ApiCall1Params>
        >
    with $Provider<RiverpodAPI<ApiCall1Model, ApiCall1Params>> {
  const ApiCall1RepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiCall1RepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiCall1RepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<ApiCall1Model, ApiCall1Params>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RiverpodAPI<ApiCall1Model, ApiCall1Params> create(Ref ref) {
    return apiCall1Repo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RiverpodAPI<ApiCall1Model, ApiCall1Params> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<RiverpodAPI<ApiCall1Model, ApiCall1Params>>(value),
    );
  }
}

String _$apiCall1RepoHash() => r'd55b13ee5563303e74b268a7f53f91ab7c22e8cf';
