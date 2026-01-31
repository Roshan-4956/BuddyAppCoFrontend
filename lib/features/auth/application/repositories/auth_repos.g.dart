// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repos.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Repository provider for getting current user

@ProviderFor(currentUserRepo)
const currentUserRepoProvider = CurrentUserRepoProvider._();

/// Repository provider for getting current user

final class CurrentUserRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<UserModel, SimpleParameters>,
          RiverpodAPI<UserModel, SimpleParameters>,
          RiverpodAPI<UserModel, SimpleParameters>
        >
    with $Provider<RiverpodAPI<UserModel, SimpleParameters>> {
  /// Repository provider for getting current user
  const CurrentUserRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<UserModel, SimpleParameters>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RiverpodAPI<UserModel, SimpleParameters> create(Ref ref) {
    return currentUserRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RiverpodAPI<UserModel, SimpleParameters> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<RiverpodAPI<UserModel, SimpleParameters>>(value),
    );
  }
}

String _$currentUserRepoHash() => r'e43aaabc1cc5f49357c716f7994598116c02b481';

/// Repository provider for forgot password API calls

@ProviderFor(forgotPasswordRepo)
const forgotPasswordRepoProvider = ForgotPasswordRepoProvider._();

/// Repository provider for forgot password API calls

final class ForgotPasswordRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<PasswordResetModel, ForgotPasswordParams>,
          RiverpodAPI<PasswordResetModel, ForgotPasswordParams>,
          RiverpodAPI<PasswordResetModel, ForgotPasswordParams>
        >
    with $Provider<RiverpodAPI<PasswordResetModel, ForgotPasswordParams>> {
  /// Repository provider for forgot password API calls
  const ForgotPasswordRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forgotPasswordRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forgotPasswordRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<PasswordResetModel, ForgotPasswordParams>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<PasswordResetModel, ForgotPasswordParams> create(Ref ref) {
    return forgotPasswordRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<PasswordResetModel, ForgotPasswordParams> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<PasswordResetModel, ForgotPasswordParams>
          >(value),
    );
  }
}

String _$forgotPasswordRepoHash() =>
    r'8b7927412ba90ea1116b5a8523ee331457790c5e';

/// Repository provider for login API calls

@ProviderFor(loginRepo)
const loginRepoProvider = LoginRepoProvider._();

/// Repository provider for login API calls

final class LoginRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<AuthResponseModel, LoginParams>,
          RiverpodAPI<AuthResponseModel, LoginParams>,
          RiverpodAPI<AuthResponseModel, LoginParams>
        >
    with $Provider<RiverpodAPI<AuthResponseModel, LoginParams>> {
  /// Repository provider for login API calls
  const LoginRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<AuthResponseModel, LoginParams>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RiverpodAPI<AuthResponseModel, LoginParams> create(Ref ref) {
    return loginRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<AuthResponseModel, LoginParams> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<RiverpodAPI<AuthResponseModel, LoginParams>>(
            value,
          ),
    );
  }
}

String _$loginRepoHash() => r'f4e55e113d49216fc724a61fe173e93123e0c3c8';

/// Repository provider for register API calls

@ProviderFor(registerRepo)
const registerRepoProvider = RegisterRepoProvider._();

/// Repository provider for register API calls

final class RegisterRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<AuthResponseModel, RegisterParams>,
          RiverpodAPI<AuthResponseModel, RegisterParams>,
          RiverpodAPI<AuthResponseModel, RegisterParams>
        >
    with $Provider<RiverpodAPI<AuthResponseModel, RegisterParams>> {
  /// Repository provider for register API calls
  const RegisterRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<AuthResponseModel, RegisterParams>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<AuthResponseModel, RegisterParams> create(Ref ref) {
    return registerRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<AuthResponseModel, RegisterParams> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<RiverpodAPI<AuthResponseModel, RegisterParams>>(
            value,
          ),
    );
  }
}

String _$registerRepoHash() => r'625c22ebcaab177c6e2406cf9d44b0ea928146c8';

/// Repository provider for reset password API calls

@ProviderFor(resetPasswordRepo)
const resetPasswordRepoProvider = ResetPasswordRepoProvider._();

/// Repository provider for reset password API calls

final class ResetPasswordRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<PasswordResetModel, ResetPasswordParams>,
          RiverpodAPI<PasswordResetModel, ResetPasswordParams>,
          RiverpodAPI<PasswordResetModel, ResetPasswordParams>
        >
    with $Provider<RiverpodAPI<PasswordResetModel, ResetPasswordParams>> {
  /// Repository provider for reset password API calls
  const ResetPasswordRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetPasswordRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetPasswordRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<PasswordResetModel, ResetPasswordParams>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<PasswordResetModel, ResetPasswordParams> create(Ref ref) {
    return resetPasswordRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<PasswordResetModel, ResetPasswordParams> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<PasswordResetModel, ResetPasswordParams>
          >(value),
    );
  }
}

String _$resetPasswordRepoHash() => r'5d218c7abbdde6f694a100f46fdd83c72e06fd10';

/// Repository provider for OTP verification API calls

@ProviderFor(verifyOtpRepo)
const verifyOtpRepoProvider = VerifyOtpRepoProvider._();

/// Repository provider for OTP verification API calls

final class VerifyOtpRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<OtpVerificationModel, VerifyOtpParams>,
          RiverpodAPI<OtpVerificationModel, VerifyOtpParams>,
          RiverpodAPI<OtpVerificationModel, VerifyOtpParams>
        >
    with $Provider<RiverpodAPI<OtpVerificationModel, VerifyOtpParams>> {
  /// Repository provider for OTP verification API calls
  const VerifyOtpRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyOtpRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyOtpRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<OtpVerificationModel, VerifyOtpParams>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<OtpVerificationModel, VerifyOtpParams> create(Ref ref) {
    return verifyOtpRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<OtpVerificationModel, VerifyOtpParams> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            RiverpodAPI<OtpVerificationModel, VerifyOtpParams>
          >(value),
    );
  }
}

String _$verifyOtpRepoHash() => r'f918383fcc9d8c2a574424fbb63377d3fe366c86';

/// Repository provider for Firebase token generation

@ProviderFor(firebaseTokenRepo)
const firebaseTokenRepoProvider = FirebaseTokenRepoProvider._();

/// Repository provider for Firebase token generation

final class FirebaseTokenRepoProvider
    extends
        $FunctionalProvider<
          RiverpodAPI<FirebaseTokenModel, SimpleParameters>,
          RiverpodAPI<FirebaseTokenModel, SimpleParameters>,
          RiverpodAPI<FirebaseTokenModel, SimpleParameters>
        >
    with $Provider<RiverpodAPI<FirebaseTokenModel, SimpleParameters>> {
  /// Repository provider for Firebase token generation
  const FirebaseTokenRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseTokenRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseTokenRepoHash();

  @$internal
  @override
  $ProviderElement<RiverpodAPI<FirebaseTokenModel, SimpleParameters>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RiverpodAPI<FirebaseTokenModel, SimpleParameters> create(Ref ref) {
    return firebaseTokenRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    RiverpodAPI<FirebaseTokenModel, SimpleParameters> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<RiverpodAPI<FirebaseTokenModel, SimpleParameters>>(
            value,
          ),
    );
  }
}

String _$firebaseTokenRepoHash() => r'6465e1ca0db2929481a93aee357b9e11280e9f62';
