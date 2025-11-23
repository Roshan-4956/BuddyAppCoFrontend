// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_preference_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedGenderPreference)
const selectedGenderPreferenceProvider = SelectedGenderPreferenceProvider._();

final class SelectedGenderPreferenceProvider
    extends $NotifierProvider<SelectedGenderPreference, int> {
  const SelectedGenderPreferenceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedGenderPreferenceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedGenderPreferenceHash();

  @$internal
  @override
  SelectedGenderPreference create() => SelectedGenderPreference();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$selectedGenderPreferenceHash() =>
    r'62aaa066756e2ac3d0d74e819ab23386a607085e';

abstract class _$SelectedGenderPreference extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
