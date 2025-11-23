// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_progress_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Repository for fetching onboarding progress from GET /onboarding/progress

@ProviderFor(onboardingProgressRepo)
const onboardingProgressRepoProvider = OnboardingProgressRepoProvider._();

/// Repository for fetching onboarding progress from GET /onboarding/progress

final class OnboardingProgressRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<OnboardingProgressModel, SimpleParameters>,
          RiverpodAPI<OnboardingProgressModel, SimpleParameters>,
          RiverpodAPI<OnboardingProgressModel, SimpleParameters>
        >
    with $Provider<RiverpodAPI<OnboardingProgressModel, SimpleParameters>> {
  /// Repository for fetching onboarding progress from GET /onboarding/progress
  const OnboardingProgressRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingProgressRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingProgressRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<OnboardingProgressModel, SimpleParameters>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<OnboardingProgressModel, SimpleParameters> create(Ref ref) {
    return onboardingProgressRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<OnboardingProgressModel, SimpleParameters> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<OnboardingProgressModel, SimpleParameters>
          >(value),
    );
  }
}

String _$onboardingProgressRepoHash() =>
    r'8052f230347718887fd08b1dc0a051ec4e703493';
