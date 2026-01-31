// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_step_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Repository for submitting onboarding step data to POST /onboarding/step

@ProviderFor(submitStepRepo)
const submitStepRepoProvider = SubmitStepRepoProvider._();

/// Repository for submitting onboarding step data to POST /onboarding/step

final class SubmitStepRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<OnboardingStepResponseModel, SubmitStepParams>,
          RiverpodAPI<OnboardingStepResponseModel, SubmitStepParams>,
          RiverpodAPI<OnboardingStepResponseModel, SubmitStepParams>
        >
    with $Provider<RiverpodAPI<OnboardingStepResponseModel, SubmitStepParams>> {
  /// Repository for submitting onboarding step data to POST /onboarding/step
  const SubmitStepRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'submitStepRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$submitStepRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<OnboardingStepResponseModel, SubmitStepParams>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<OnboardingStepResponseModel, SubmitStepParams> create(Ref ref) {
    return submitStepRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<OnboardingStepResponseModel, SubmitStepParams> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<OnboardingStepResponseModel, SubmitStepParams>
          >(value),
    );
  }
}

String _$submitStepRepoHash() => r'1cbaaf51a49ef82b7e1d0fe8a1995b6af34848bd';
