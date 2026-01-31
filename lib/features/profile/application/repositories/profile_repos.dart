import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../utils/api/api_paths.dart';
import '../../../../utils/api/core/http_method.dart';
import '../../../../utils/api/implementation/riverpod_api/riverpod_api.dart';
import '../../../../utils/api/implementation/simple_api/simple_params.dart';
import '../../../../utils/factory_utils.dart';
import '../../../../utils/urls.dart';
import '../models/profile_models.dart';
import 'profile_params.dart';

part 'profile_repos.g.dart';

@Riverpod(keepAlive: true)
RiverpodAPI<ProfileQuestionsResponseModel, ProfileQuestionsParams>
profileQuestionsRepo(Ref ref, {required ProfileSection section}) {
  return RiverpodAPI<ProfileQuestionsResponseModel, ProfileQuestionsParams>(
    completeUrl: URLs.complete(ApiPaths.profileQuestions),
    factory: FactoryUtils.modelFromString(
      ProfileQuestionsResponseModel.fromJson,
      subtag: 'data',
    ),
    params: ProfileQuestionsParams(section),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: true,
  );
}

@Riverpod(keepAlive: true)
RiverpodAPI<ProfileAnswerModel, ProfileAnswerCreateParams>
submitProfileAnswerRepo(Ref ref) {
  return RiverpodAPI<ProfileAnswerModel, ProfileAnswerCreateParams>(
    completeUrl: URLs.complete(ApiPaths.profileAnswers),
    factory: FactoryUtils.modelFromString(
      ProfileAnswerModel.fromJson,
      subtag: 'data',
    ),
    params: ProfileAnswerCreateParams(),
    method: HTTPMethod.post,
    ref: ref,
    requiresAuth: true,
  );
}

@Riverpod(keepAlive: true)
RiverpodAPI<ProfileAnswersResponseModel, SimpleParameters> profileAnswersRepo(
  Ref ref,
) {
  return RiverpodAPI<ProfileAnswersResponseModel, SimpleParameters>(
    completeUrl: URLs.complete(ApiPaths.profileAnswers),
    factory: FactoryUtils.modelFromString(
      ProfileAnswersResponseModel.fromJson,
      subtag: 'data',
    ),
    params: SimpleParameters(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: true,
  );
}

@Riverpod(keepAlive: true)
RiverpodAPI<ProfileAnswerModel, SimpleParameters> profileAnswerRepo(
  Ref ref, {
  required String answerId,
}) {
  return RiverpodAPI<ProfileAnswerModel, SimpleParameters>(
    completeUrl: URLs.complete('${ApiPaths.profileAnswers}/$answerId'),
    factory: FactoryUtils.modelFromString(
      ProfileAnswerModel.fromJson,
      subtag: 'data',
    ),
    params: SimpleParameters(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: true,
  );
}

@Riverpod(keepAlive: true)
RiverpodAPI<ProfileAnswerModel, ProfileAnswerUpdateParams>
updateProfileAnswerRepo(Ref ref, {required String answerId}) {
  return RiverpodAPI<ProfileAnswerModel, ProfileAnswerUpdateParams>(
    completeUrl: URLs.complete('${ApiPaths.profileAnswers}/$answerId'),
    factory: FactoryUtils.modelFromString(
      ProfileAnswerModel.fromJson,
      subtag: 'data',
    ),
    params: ProfileAnswerUpdateParams(),
    method: HTTPMethod.put,
    ref: ref,
    requiresAuth: true,
  );
}

@Riverpod(keepAlive: true)
RiverpodAPI<ProfileAnswerModel, ProfilePinParams> pinProfileAnswerRepo(
  Ref ref, {
  required String answerId,
  bool isPinned = true,
}) {
  return RiverpodAPI<ProfileAnswerModel, ProfilePinParams>(
    completeUrl: URLs.complete('${ApiPaths.profileAnswers}/$answerId/pin'),
    factory: FactoryUtils.modelFromString(
      ProfileAnswerModel.fromJson,
      subtag: 'data',
    ),
    params: ProfilePinParams(isPinned: isPinned),
    method: HTTPMethod.post,
    ref: ref,
    requiresAuth: true,
  );
}

@Riverpod(keepAlive: true)
RiverpodAPI<BasicResponseModel, SimpleParameters> deleteProfileAnswerRepo(
  Ref ref, {
  required String answerId,
}) {
  return RiverpodAPI<BasicResponseModel, SimpleParameters>(
    completeUrl: URLs.complete('${ApiPaths.profileAnswers}/$answerId'),
    factory: FactoryUtils.modelFromString(BasicResponseModel.fromJson),
    params: SimpleParameters(),
    method: HTTPMethod.delete,
    ref: ref,
    requiresAuth: true,
  );
}

@Riverpod(keepAlive: true)
RiverpodAPI<ProfileCompletionModel, SimpleParameters> profileCompletionRepo(
  Ref ref,
) {
  return RiverpodAPI<ProfileCompletionModel, SimpleParameters>(
    completeUrl: URLs.complete(ApiPaths.profileCompletion),
    factory: FactoryUtils.modelFromString(
      ProfileCompletionModel.fromJson,
      subtag: 'data',
    ),
    params: SimpleParameters(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: true,
  );
}

@Riverpod(keepAlive: true)
RiverpodAPI<ProfileViewModel, SimpleParameters> profileViewRepo(Ref ref) {
  return RiverpodAPI<ProfileViewModel, SimpleParameters>(
    completeUrl: URLs.complete(ApiPaths.profileMe),
    factory: FactoryUtils.modelFromString(
      ProfileViewModel.fromJson,
      subtag: 'data',
    ),
    params: SimpleParameters(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: true,
  );
}
