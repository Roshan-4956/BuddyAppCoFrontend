// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_repos.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileQuestionsRepo)
const profileQuestionsRepoProvider = ProfileQuestionsRepoFamily._();

final class ProfileQuestionsRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<ProfileQuestionsResponseModel, ProfileQuestionsParams>,
          RiverpodAPI<ProfileQuestionsResponseModel, ProfileQuestionsParams>,
          RiverpodAPI<ProfileQuestionsResponseModel, ProfileQuestionsParams>
        >
    with
        $Provider<
          RiverpodAPI<ProfileQuestionsResponseModel, ProfileQuestionsParams>
        > {
  const ProfileQuestionsRepoProvider._({
    required ProfileQuestionsRepoFamily super.from,
    required ProfileSection super.argument,
  }) : super(
         retry: null,
         name: r'profileQuestionsRepoProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$profileQuestionsRepoHash();

  @override
  String toString() {
    return r'profileQuestionsRepoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<
    RiverpodAPI<ProfileQuestionsResponseModel, ProfileQuestionsParams>
  >
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<ProfileQuestionsResponseModel, ProfileQuestionsParams> create(
    Ref ref,
  ) {
    final argument = this.argument as ProfileSection;
    return profileQuestionsRepo(ref, section: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<ProfileQuestionsResponseModel, ProfileQuestionsParams> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<ProfileQuestionsResponseModel, ProfileQuestionsParams>
          >(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileQuestionsRepoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$profileQuestionsRepoHash() =>
    r'0a60dc22e77cdc2a280d2a58124990594bb019c0';

final class ProfileQuestionsRepoFamily extends $Family
    with
        $FunctionalFamilyOverride<
          RiverpodAPI<ProfileQuestionsResponseModel, ProfileQuestionsParams>,
          ProfileSection
        > {
  const ProfileQuestionsRepoFamily._()
    : super(
        retry: null,
        name: r'profileQuestionsRepoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ProfileQuestionsRepoProvider call({required ProfileSection section}) =>
      ProfileQuestionsRepoProvider._(argument: section, from: this);

  @override
  String toString() => r'profileQuestionsRepoProvider';
}

@ProviderFor(submitProfileAnswerRepo)
const submitProfileAnswerRepoProvider = SubmitProfileAnswerRepoProvider._();

final class SubmitProfileAnswerRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<ProfileAnswerModel, ProfileAnswerCreateParams>,
          RiverpodAPI<ProfileAnswerModel, ProfileAnswerCreateParams>,
          RiverpodAPI<ProfileAnswerModel, ProfileAnswerCreateParams>
        >
    with $Provider<RiverpodAPI<ProfileAnswerModel, ProfileAnswerCreateParams>> {
  const SubmitProfileAnswerRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'submitProfileAnswerRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$submitProfileAnswerRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<ProfileAnswerModel, ProfileAnswerCreateParams>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<ProfileAnswerModel, ProfileAnswerCreateParams> create(Ref ref) {
    return submitProfileAnswerRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<ProfileAnswerModel, ProfileAnswerCreateParams> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<ProfileAnswerModel, ProfileAnswerCreateParams>
          >(value),
    );
  }
}

String _$submitProfileAnswerRepoHash() =>
    r'd7fe7fb7b8393df317b78796445feb6c9611b400';

@ProviderFor(profileAnswersRepo)
const profileAnswersRepoProvider = ProfileAnswersRepoProvider._();

final class ProfileAnswersRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<ProfileAnswersResponseModel, SimpleParameters>,
          RiverpodAPI<ProfileAnswersResponseModel, SimpleParameters>,
          RiverpodAPI<ProfileAnswersResponseModel, SimpleParameters>
        >
    with $Provider<RiverpodAPI<ProfileAnswersResponseModel, SimpleParameters>> {
  const ProfileAnswersRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileAnswersRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileAnswersRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<ProfileAnswersResponseModel, SimpleParameters>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<ProfileAnswersResponseModel, SimpleParameters> create(Ref ref) {
    return profileAnswersRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<ProfileAnswersResponseModel, SimpleParameters> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<ProfileAnswersResponseModel, SimpleParameters>
          >(value),
    );
  }
}

String _$profileAnswersRepoHash() =>
    r'6d01ebc4da97d3858297bc38189fb3f956bd2f12';

@ProviderFor(profileAnswerRepo)
const profileAnswerRepoProvider = ProfileAnswerRepoFamily._();

final class ProfileAnswerRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<ProfileAnswerModel, SimpleParameters>,
          RiverpodAPI<ProfileAnswerModel, SimpleParameters>,
          RiverpodAPI<ProfileAnswerModel, SimpleParameters>
        >
    with $Provider<RiverpodAPI<ProfileAnswerModel, SimpleParameters>> {
  const ProfileAnswerRepoProvider._({
    required ProfileAnswerRepoFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'profileAnswerRepoProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$profileAnswerRepoHash();

  @override
  String toString() {
    return r'profileAnswerRepoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<RiverpodAPI<ProfileAnswerModel, SimpleParameters>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<ProfileAnswerModel, SimpleParameters> create(Ref ref) {
    final argument = this.argument as String;
    return profileAnswerRepo(ref, answerId: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<ProfileAnswerModel, SimpleParameters> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<RiverpodAPI<ProfileAnswerModel, SimpleParameters>>(
            value,
          ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileAnswerRepoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$profileAnswerRepoHash() => r'5582292d87236e9453ef2998fc59a5d645e3092c';

final class ProfileAnswerRepoFamily extends $Family
    with
        $FunctionalFamilyOverride<
          RiverpodAPI<ProfileAnswerModel, SimpleParameters>,
          String
        > {
  const ProfileAnswerRepoFamily._()
    : super(
        retry: null,
        name: r'profileAnswerRepoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ProfileAnswerRepoProvider call({required String answerId}) =>
      ProfileAnswerRepoProvider._(argument: answerId, from: this);

  @override
  String toString() => r'profileAnswerRepoProvider';
}

@ProviderFor(updateProfileAnswerRepo)
const updateProfileAnswerRepoProvider = UpdateProfileAnswerRepoFamily._();

final class UpdateProfileAnswerRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<ProfileAnswerModel, ProfileAnswerUpdateParams>,
          RiverpodAPI<ProfileAnswerModel, ProfileAnswerUpdateParams>,
          RiverpodAPI<ProfileAnswerModel, ProfileAnswerUpdateParams>
        >
    with $Provider<RiverpodAPI<ProfileAnswerModel, ProfileAnswerUpdateParams>> {
  const UpdateProfileAnswerRepoProvider._({
    required UpdateProfileAnswerRepoFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'updateProfileAnswerRepoProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$updateProfileAnswerRepoHash();

  @override
  String toString() {
    return r'updateProfileAnswerRepoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<RiverpodAPI<ProfileAnswerModel, ProfileAnswerUpdateParams>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<ProfileAnswerModel, ProfileAnswerUpdateParams> create(Ref ref) {
    final argument = this.argument as String;
    return updateProfileAnswerRepo(ref, answerId: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<ProfileAnswerModel, ProfileAnswerUpdateParams> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<ProfileAnswerModel, ProfileAnswerUpdateParams>
          >(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateProfileAnswerRepoProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateProfileAnswerRepoHash() =>
    r'64f5c38a2ab058ec8c3520c968f7a283437a0c01';

final class UpdateProfileAnswerRepoFamily extends $Family
    with
        $FunctionalFamilyOverride<
          RiverpodAPI<ProfileAnswerModel, ProfileAnswerUpdateParams>,
          String
        > {
  const UpdateProfileAnswerRepoFamily._()
    : super(
        retry: null,
        name: r'updateProfileAnswerRepoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  UpdateProfileAnswerRepoProvider call({required String answerId}) =>
      UpdateProfileAnswerRepoProvider._(argument: answerId, from: this);

  @override
  String toString() => r'updateProfileAnswerRepoProvider';
}

@ProviderFor(pinProfileAnswerRepo)
const pinProfileAnswerRepoProvider = PinProfileAnswerRepoFamily._();

final class PinProfileAnswerRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<ProfileAnswerModel, ProfilePinParams>,
          RiverpodAPI<ProfileAnswerModel, ProfilePinParams>,
          RiverpodAPI<ProfileAnswerModel, ProfilePinParams>
        >
    with $Provider<RiverpodAPI<ProfileAnswerModel, ProfilePinParams>> {
  const PinProfileAnswerRepoProvider._({
    required PinProfileAnswerRepoFamily super.from,
    required ({String answerId, bool isPinned}) super.argument,
  }) : super(
         retry: null,
         name: r'pinProfileAnswerRepoProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pinProfileAnswerRepoHash();

  @override
  String toString() {
    return r'pinProfileAnswerRepoProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<RiverpodAPI<ProfileAnswerModel, ProfilePinParams>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<ProfileAnswerModel, ProfilePinParams> create(Ref ref) {
    final argument = this.argument as ({String answerId, bool isPinned});
    return pinProfileAnswerRepo(
      ref,
      answerId: argument.answerId,
      isPinned: argument.isPinned,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<ProfileAnswerModel, ProfilePinParams> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<RiverpodAPI<ProfileAnswerModel, ProfilePinParams>>(
            value,
          ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PinProfileAnswerRepoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pinProfileAnswerRepoHash() =>
    r'5048cb5373a4f9a77ed164ad351a2ea3d08d6e61';

final class PinProfileAnswerRepoFamily extends $Family
    with
        $FunctionalFamilyOverride<
          RiverpodAPI<ProfileAnswerModel, ProfilePinParams>,
          ({String answerId, bool isPinned})
        > {
  const PinProfileAnswerRepoFamily._()
    : super(
        retry: null,
        name: r'pinProfileAnswerRepoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  PinProfileAnswerRepoProvider call({
    required String answerId,
    bool isPinned = true,
  }) => PinProfileAnswerRepoProvider._(
    argument: (answerId: answerId, isPinned: isPinned),
    from: this,
  );

  @override
  String toString() => r'pinProfileAnswerRepoProvider';
}

@ProviderFor(deleteProfileAnswerRepo)
const deleteProfileAnswerRepoProvider = DeleteProfileAnswerRepoFamily._();

final class DeleteProfileAnswerRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<BasicResponseModel, SimpleParameters>,
          RiverpodAPI<BasicResponseModel, SimpleParameters>,
          RiverpodAPI<BasicResponseModel, SimpleParameters>
        >
    with $Provider<RiverpodAPI<BasicResponseModel, SimpleParameters>> {
  const DeleteProfileAnswerRepoProvider._({
    required DeleteProfileAnswerRepoFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'deleteProfileAnswerRepoProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deleteProfileAnswerRepoHash();

  @override
  String toString() {
    return r'deleteProfileAnswerRepoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<RiverpodAPI<BasicResponseModel, SimpleParameters>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<BasicResponseModel, SimpleParameters> create(Ref ref) {
    final argument = this.argument as String;
    return deleteProfileAnswerRepo(ref, answerId: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<BasicResponseModel, SimpleParameters> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<RiverpodAPI<BasicResponseModel, SimpleParameters>>(
            value,
          ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteProfileAnswerRepoProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deleteProfileAnswerRepoHash() =>
    r'93f1cc72cbb189088acdd4ad4fac52d59050623d';

final class DeleteProfileAnswerRepoFamily extends $Family
    with
        $FunctionalFamilyOverride<
          RiverpodAPI<BasicResponseModel, SimpleParameters>,
          String
        > {
  const DeleteProfileAnswerRepoFamily._()
    : super(
        retry: null,
        name: r'deleteProfileAnswerRepoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  DeleteProfileAnswerRepoProvider call({required String answerId}) =>
      DeleteProfileAnswerRepoProvider._(argument: answerId, from: this);

  @override
  String toString() => r'deleteProfileAnswerRepoProvider';
}

@ProviderFor(profileCompletionRepo)
const profileCompletionRepoProvider = ProfileCompletionRepoProvider._();

final class ProfileCompletionRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<ProfileCompletionModel, SimpleParameters>,
          RiverpodAPI<ProfileCompletionModel, SimpleParameters>,
          RiverpodAPI<ProfileCompletionModel, SimpleParameters>
        >
    with $Provider<RiverpodAPI<ProfileCompletionModel, SimpleParameters>> {
  const ProfileCompletionRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileCompletionRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileCompletionRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<ProfileCompletionModel, SimpleParameters>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<ProfileCompletionModel, SimpleParameters> create(Ref ref) {
    return profileCompletionRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<ProfileCompletionModel, SimpleParameters> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<ProfileCompletionModel, SimpleParameters>
          >(value),
    );
  }
}

String _$profileCompletionRepoHash() =>
    r'8eab0adf0030ebae97f252f9a99a7af643073bcb';

@ProviderFor(profileViewRepo)
const profileViewRepoProvider = ProfileViewRepoProvider._();

final class ProfileViewRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<ProfileViewModel, SimpleParameters>,
          RiverpodAPI<ProfileViewModel, SimpleParameters>,
          RiverpodAPI<ProfileViewModel, SimpleParameters>
        >
    with $Provider<RiverpodAPI<ProfileViewModel, SimpleParameters>> {
  const ProfileViewRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileViewRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileViewRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<ProfileViewModel, SimpleParameters>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<ProfileViewModel, SimpleParameters> create(Ref ref) {
    return profileViewRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<ProfileViewModel, SimpleParameters> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<RiverpodAPI<ProfileViewModel, SimpleParameters>>(
            value,
          ),
    );
  }
}

String _$profileViewRepoHash() => r'4464af6b86d3e0efdb325238f0aede8e7d96ab07';
