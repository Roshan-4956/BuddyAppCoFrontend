// This file sets up the Riverpod repository for API Call 1.
// It configures the HTTP method, the API URL, and the model factory method.
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/api/core/http_method.dart';
import '../../../utils/api/implementation/riverpod_api/riverpod_api.dart';
import '../../../utils/factory_utils.dart';
import '../../../utils/urls.dart';
import 'api_call_1_model.dart';
import 'api_call_1_params.dart';

part 'api_call_1_repo.g.dart';

// The @Riverpod annotation creates a provider that remains alive.
// This provider is responsible for managing API calls using RiverpodAPI.
@Riverpod(keepAlive: true)
RiverpodAPI<ApiCall1Model, ApiCall1Params> apiCall1Repo(Ref ref) {
  // This function returns a RiverpodAPI instance configured for API Call 1.
  return RiverpodAPI<ApiCall1Model, ApiCall1Params>(
    completeUrl: URLs.complete(
      'some_random_api_call/{random_id}',
    ), // URL with placeholder for dynamic data.
    factory: FactoryUtils.modelFromString(
      ApiCall1Model.fromJson,
    ), // Converts JSON to ApiCall1Model.
    params:
        ApiCall1Params(), // Parameter object that formats URL and holds extra data.
    method: HTTPMethod.get, // HTTP method for the API call.
    ref: ref, // Riverpod reference for managing lifecycle and state.
  );
}
