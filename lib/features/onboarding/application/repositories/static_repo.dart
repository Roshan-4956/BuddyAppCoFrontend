import 'package:buddy_app/utils/api/core/http_method.dart';
import 'package:buddy_app/utils/api/implementation/riverpod_api/riverpod_api.dart';
import 'package:buddy_app/utils/api/implementation/simple_api/simple_params.dart';
import 'package:buddy_app/utils/factory_utils.dart';
import 'package:buddy_app/utils/urls.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/state_model.dart';
import '../models/city_model.dart';
import '../models/gender_model.dart';
import '../models/occupation_model.dart';
import '../models/interest_model.dart';

part 'static_repo.g.dart';

// =============================================================================
// STATES REPOSITORY
// =============================================================================

/// Repository for fetching available states from GET /static/states
@Riverpod(keepAlive: true)
RiverpodAPI<StatesResponseModel, SimpleParameters> statesRepo(Ref ref) {
  return RiverpodAPI<StatesResponseModel, SimpleParameters>(
    completeUrl: URLs.complete('static/states'),
    factory: FactoryUtils.modelFromString(
      StatesResponseModel.fromJson,
      subtag: 'data',
    ),
    params: SimpleParameters(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: false,
  );
}

// =============================================================================
// CITIES REPOSITORY
// =============================================================================

/// Parameters for filtering cities by state ID
class CitiesParameters extends SimpleParameters {
  CitiesParameters({int? stateId}) {
    if (stateId != null) {
      queryParams['state_id'] = stateId.toString();
    }
  }
}

/// Repository for fetching cities from GET /static/cities
/// Optionally filter by state_id using the stateId parameter
@Riverpod(keepAlive: true)
RiverpodAPI<CitiesResponseModel, CitiesParameters> citiesRepo(
  Ref ref, {
  int? stateId,
}) {
  return RiverpodAPI<CitiesResponseModel, CitiesParameters>(
    completeUrl: URLs.complete('static/cities'),
    factory: FactoryUtils.modelFromString(
      CitiesResponseModel.fromJson,
      subtag: 'data',
    ),
    params: CitiesParameters(stateId: stateId),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: false,
  );
}

// =============================================================================
// GENDERS REPOSITORY
// =============================================================================

/// Repository for fetching available genders from GET /static/genders
@Riverpod(keepAlive: true)
RiverpodAPI<GendersResponseModel, SimpleParameters> gendersRepo(Ref ref) {
  return RiverpodAPI<GendersResponseModel, SimpleParameters>(
    completeUrl: URLs.complete('static/genders'),
    factory: FactoryUtils.modelFromString(
      GendersResponseModel.fromJson,
      subtag: 'data',
    ),
    params: SimpleParameters(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: false,
  );
}

// =============================================================================
// OCCUPATIONS REPOSITORY
// =============================================================================

/// Repository for fetching available occupations from GET /static/occupations
@Riverpod(keepAlive: true)
RiverpodAPI<OccupationsResponseModel, SimpleParameters> occupationsRepo(
  Ref ref,
) {
  return RiverpodAPI<OccupationsResponseModel, SimpleParameters>(
    completeUrl: URLs.complete('static/occupations'),
    factory: FactoryUtils.modelFromString(
      OccupationsResponseModel.fromJson,
      subtag: 'data',
    ),
    params: SimpleParameters(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: false,
  );
}

// =============================================================================
// INTERESTS REPOSITORY
// =============================================================================

/// Repository for fetching available interests from GET /static/interests
@Riverpod(keepAlive: true)
RiverpodAPI<InterestsResponseModel, SimpleParameters> interestsRepo(Ref ref) {
  return RiverpodAPI<InterestsResponseModel, SimpleParameters>(
    completeUrl: URLs.complete('static/interests'),
    factory: FactoryUtils.modelFromString(
      InterestsResponseModel.fromJson,
      subtag: 'data',
    ),
    params: SimpleParameters(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: false,
  );
}
