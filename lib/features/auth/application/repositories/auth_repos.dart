import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../utils/api/core/http_method.dart';
import '../../../../utils/api/implementation/riverpod_api/riverpod_api.dart';
import '../../../../utils/api/implementation/simple_api/simple_params.dart';
import '../../../../utils/factory_utils.dart';
import '../../../../utils/api/api_paths.dart';
import '../../../../utils/urls.dart';
import '../models/auth_models.dart';
import 'auth_params.dart';

part 'auth_repos.g.dart';

/// Repository provider for getting current user
@Riverpod(keepAlive: true)
RiverpodAPI<UserModel, SimpleParameters> currentUserRepo(Ref ref) {
  return RiverpodAPI<UserModel, SimpleParameters>(
    completeUrl: URLs.complete(ApiPaths.authMe),
    factory: FactoryUtils.modelFromString(UserModel.fromJson, subtag: 'data'),
    params: SimpleParameters(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: true, // This endpoint requires authentication
  );
}

/// Repository provider for forgot password API calls
@Riverpod(keepAlive: true)
RiverpodAPI<PasswordResetModel, ForgotPasswordParams> forgotPasswordRepo(
  Ref ref,
) {
  return RiverpodAPI<PasswordResetModel, ForgotPasswordParams>(
    completeUrl: URLs.complete(ApiPaths.authForgotPassword),
    factory: FactoryUtils.modelFromString(
      PasswordResetModel.fromJson,
      subtag: 'data',
    ),
    params: ForgotPasswordParams(),
    method: HTTPMethod.post,
    ref: ref,
    requiresAuth: false,
  );
}

/// Repository provider for login API calls
@Riverpod(keepAlive: true)
RiverpodAPI<AuthResponseModel, LoginParams> loginRepo(Ref ref) {
  return RiverpodAPI<AuthResponseModel, LoginParams>(
    completeUrl: URLs.complete(ApiPaths.authLogin),
    factory: FactoryUtils.modelFromString(
      AuthResponseModel.fromJson,
      subtag: 'data',
    ),
    params: LoginParams(),
    method: HTTPMethod.post,
    ref: ref,
    requiresAuth: false, // Login doesn't require authentication
  );
}

/// Repository provider for register API calls
@Riverpod(keepAlive: true)
RiverpodAPI<AuthResponseModel, RegisterParams> registerRepo(Ref ref) {
  return RiverpodAPI<AuthResponseModel, RegisterParams>(
    completeUrl: URLs.complete(ApiPaths.authRegisterEmail),
    factory: FactoryUtils.modelFromString(
      AuthResponseModel.fromJson,
      subtag: 'data',
    ),
    params: RegisterParams(),
    method: HTTPMethod.post,
    ref: ref,
    requiresAuth: false,
  );
}

/// Repository provider for reset password API calls
@Riverpod(keepAlive: true)
RiverpodAPI<PasswordResetModel, ResetPasswordParams> resetPasswordRepo(
  Ref ref,
) {
  return RiverpodAPI<PasswordResetModel, ResetPasswordParams>(
    completeUrl: URLs.complete(ApiPaths.authResetPassword),
    factory: FactoryUtils.modelFromString(
      PasswordResetModel.fromJson,
      subtag: 'data',
    ),
    params: ResetPasswordParams(),
    method: HTTPMethod.post,
    ref: ref,
    requiresAuth: false,
  );
}

/// Repository provider for OTP verification API calls
@Riverpod(keepAlive: true)
RiverpodAPI<OtpVerificationModel, VerifyOtpParams> verifyOtpRepo(Ref ref) {
  return RiverpodAPI<OtpVerificationModel, VerifyOtpParams>(
    completeUrl: URLs.complete(ApiPaths.authVerifyOtp),
    factory: FactoryUtils.modelFromString(
      OtpVerificationModel.fromJson,
      subtag: 'data',
    ),
    params: VerifyOtpParams(),
    method: HTTPMethod.post,
    ref: ref,
    requiresAuth: false,
  );
}

/// Repository provider for Firebase token generation
@Riverpod(keepAlive: true)
RiverpodAPI<FirebaseTokenModel, SimpleParameters> firebaseTokenRepo(Ref ref) {
  return RiverpodAPI<FirebaseTokenModel, SimpleParameters>(
    completeUrl: URLs.complete(ApiPaths.authFirebaseToken),
    factory: FactoryUtils.modelFromString(
      FirebaseTokenModel.fromJson,
      subtag: 'data',
    ),
    params: SimpleParameters(),
    method: HTTPMethod.get,
    ref: ref,
    requiresAuth: true,
  );
}
