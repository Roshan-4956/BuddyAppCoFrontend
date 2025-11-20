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

String _$currentUserRepoHash() => r'418d05d428a59c4be1b495a4e370d5e1d56bb451';

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
    r'3e151ddddb038d2feadb03fd4c689602d9ad06fe';

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

String _$loginRepoHash() => r'0e54aceb264d26f49556f3427517815a7b6fb011';

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

String _$registerRepoHash() => r'7a62f5d670548f58438237e76e115e3c4f736a66';

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

String _$resetPasswordRepoHash() => r'dfe2c802a77154f74fab577c14da65354a4d528e';

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

String _$verifyOtpRepoHash() => r'6c1b584d7637f5f7a4273e398b76298a1116eae7';
