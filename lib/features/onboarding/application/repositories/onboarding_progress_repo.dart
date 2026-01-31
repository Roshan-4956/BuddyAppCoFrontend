import 'package:buddy_app/utils/api/core/http_method.dart';
import 'package:buddy_app/utils/api/implementation/riverpod_api/riverpod_api.dart';
import 'package:buddy_app/utils/api/implementation/simple_api/simple_params.dart';
import 'package:buddy_app/utils/factory_utils.dart';
import 'package:buddy_app/utils/api/api_paths.dart';
import 'package:buddy_app/utils/urls.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/onboarding_progress_model.dart';

part 'onboarding_progress_repo.g.dart';

/// Repository for fetching onboarding progress from GET /onboarding/progress
@Riverpod(keepAlive: true)
RiverpodAPI<OnboardingProgressModel, SimpleParameters> onboardingProgressRepo(
  Ref ref,
) {
  return RiverpodAPI<OnboardingProgressModel, SimpleParameters>(
    completeUrl: URLs.complete(ApiPaths.onboardingProgress),
    factory: FactoryUtils.modelFromString(
      OnboardingProgressModel.fromJson,
      subtag: 'data',
    ),
    params: SimpleParameters(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: true,
  );
}
