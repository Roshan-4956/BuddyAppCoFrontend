import 'package:buddy_app/utils/api/core/http_method.dart';
import 'package:buddy_app/utils/api/implementation/riverpod_api/riverpod_api.dart';
import 'package:buddy_app/utils/api/implementation/simple_api/simple_params.dart';
import 'package:buddy_app/utils/factory_utils.dart';
import 'package:buddy_app/utils/urls.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/onboarding_step_response_model.dart';

part 'submit_step_repo.g.dart';

/// Parameters for POST /onboarding/step
class SubmitStepParams extends SimpleParameters {
  int? step;
  Map<String, dynamic>? stepData;

  void setStepData(int stepNumber, Map<String, dynamic> data) {
    step = stepNumber;
    stepData = data;
    body = {'step': stepNumber, 'data': data};
  }
}

/// Repository for submitting onboarding step data to POST /onboarding/step
@Riverpod(keepAlive: true)
RiverpodAPI<OnboardingStepResponseModel, SubmitStepParams> submitStepRepo(
  Ref ref,
) {
  return RiverpodAPI<OnboardingStepResponseModel, SubmitStepParams>(
    completeUrl: URLs.complete('onboarding/step'),
    factory: FactoryUtils.modelFromString(
      OnboardingStepResponseModel.fromJson,
      subtag: 'data',
    ),
    params: SubmitStepParams(),
    method: HTTPMethod.post,
    ref: ref,
    requiresAuth: true,
  );
}
