// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Repository for fetching available states from GET /static/states

@ProviderFor(statesRepo)
const statesRepoProvider = StatesRepoProvider._();

/// Repository for fetching available states from GET /static/states

final class StatesRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<StatesResponseModel, SimpleParameters>,
          RiverpodAPI<StatesResponseModel, SimpleParameters>,
          RiverpodAPI<StatesResponseModel, SimpleParameters>
        >
    with $Provider<RiverpodAPI<StatesResponseModel, SimpleParameters>> {
  /// Repository for fetching available states from GET /static/states
  const StatesRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statesRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statesRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<StatesResponseModel, SimpleParameters>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<StatesResponseModel, SimpleParameters> create(Ref ref) {
    return statesRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<StatesResponseModel, SimpleParameters> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<StatesResponseModel, SimpleParameters>
          >(value),
    );
  }
}

String _$statesRepoHash() => r'ac98319ed9b337144dfea1435c5ec2baa9899ea5';

/// Repository for fetching cities from GET /static/cities
/// Optionally filter by state_id using the stateId parameter

@ProviderFor(citiesRepo)
const citiesRepoProvider = CitiesRepoFamily._();

/// Repository for fetching cities from GET /static/cities
/// Optionally filter by state_id using the stateId parameter

final class CitiesRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<CitiesResponseModel, CitiesParameters>,
          RiverpodAPI<CitiesResponseModel, CitiesParameters>,
          RiverpodAPI<CitiesResponseModel, CitiesParameters>
        >
    with $Provider<RiverpodAPI<CitiesResponseModel, CitiesParameters>> {
  /// Repository for fetching cities from GET /static/cities
  /// Optionally filter by state_id using the stateId parameter
  const CitiesRepoProvider._({
    required CitiesRepoFamily super.from,
    required int? super.argument,
  }) : super(
         retry: null,
         name: r'citiesRepoProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$citiesRepoHash();

  @override
  String toString() {
    return r'citiesRepoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<RiverpodAPI<CitiesResponseModel, CitiesParameters>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<CitiesResponseModel, CitiesParameters> create(Ref ref) {
    final argument = this.argument as int?;
    return citiesRepo(ref, stateId: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<CitiesResponseModel, CitiesParameters> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<CitiesResponseModel, CitiesParameters>
          >(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CitiesRepoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$citiesRepoHash() => r'ed807b9ccfa246289b916c45a4395259b888bb14';

/// Repository for fetching cities from GET /static/cities
/// Optionally filter by state_id using the stateId parameter

final class CitiesRepoFamily extends $Family
    with
        $FunctionalFamilyOverride<
          RiverpodAPI<CitiesResponseModel, CitiesParameters>,
          int?
        > {
  const CitiesRepoFamily._()
    : super(
        retry: null,
        name: r'citiesRepoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Repository for fetching cities from GET /static/cities
  /// Optionally filter by state_id using the stateId parameter

  CitiesRepoProvider call({int? stateId}) =>
      CitiesRepoProvider._(argument: stateId, from: this);

  @override
  String toString() => r'citiesRepoProvider';
}

/// Repository for fetching available genders from GET /static/genders

@ProviderFor(gendersRepo)
const gendersRepoProvider = GendersRepoProvider._();

/// Repository for fetching available genders from GET /static/genders

final class GendersRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<GendersResponseModel, SimpleParameters>,
          RiverpodAPI<GendersResponseModel, SimpleParameters>,
          RiverpodAPI<GendersResponseModel, SimpleParameters>
        >
    with $Provider<RiverpodAPI<GendersResponseModel, SimpleParameters>> {
  /// Repository for fetching available genders from GET /static/genders
  const GendersRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gendersRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gendersRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<GendersResponseModel, SimpleParameters>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<GendersResponseModel, SimpleParameters> create(Ref ref) {
    return gendersRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<GendersResponseModel, SimpleParameters> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<GendersResponseModel, SimpleParameters>
          >(value),
    );
  }
}

String _$gendersRepoHash() => r'7475dd154565089cfe4fff462ecb268ab3563f68';

/// Repository for fetching available occupations from GET /static/occupations

@ProviderFor(occupationsRepo)
const occupationsRepoProvider = OccupationsRepoProvider._();

/// Repository for fetching available occupations from GET /static/occupations

final class OccupationsRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<OccupationsResponseModel, SimpleParameters>,
          RiverpodAPI<OccupationsResponseModel, SimpleParameters>,
          RiverpodAPI<OccupationsResponseModel, SimpleParameters>
        >
    with $Provider<RiverpodAPI<OccupationsResponseModel, SimpleParameters>> {
  /// Repository for fetching available occupations from GET /static/occupations
  const OccupationsRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'occupationsRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$occupationsRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<OccupationsResponseModel, SimpleParameters>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<OccupationsResponseModel, SimpleParameters> create(Ref ref) {
    return occupationsRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<OccupationsResponseModel, SimpleParameters> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<OccupationsResponseModel, SimpleParameters>
          >(value),
    );
  }
}

String _$occupationsRepoHash() => r'bc653330896135d767eabfdf66647756f3b84877';

/// Repository for fetching available interests from GET /static/interests

@ProviderFor(interestsRepo)
const interestsRepoProvider = InterestsRepoProvider._();

/// Repository for fetching available interests from GET /static/interests

final class InterestsRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<InterestsResponseModel, SimpleParameters>,
          RiverpodAPI<InterestsResponseModel, SimpleParameters>,
          RiverpodAPI<InterestsResponseModel, SimpleParameters>
        >
    with $Provider<RiverpodAPI<InterestsResponseModel, SimpleParameters>> {
  /// Repository for fetching available interests from GET /static/interests
  const InterestsRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interestsRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interestsRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<InterestsResponseModel, SimpleParameters>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<InterestsResponseModel, SimpleParameters> create(Ref ref) {
    return interestsRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<InterestsResponseModel, SimpleParameters> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<InterestsResponseModel, SimpleParameters>
          >(value),
    );
  }
}

String _$interestsRepoHash() => r'51c99877ec230920357c118bf5330ea7b39a145d';
