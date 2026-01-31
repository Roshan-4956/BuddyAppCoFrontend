/// Onboarding progress model
class OnboardingProgressModel {
  final String flowId;
  final int currentStep;
  final int totalSteps;
  final double progressPercentage;

  OnboardingProgressModel({
    required this.flowId,
    required this.currentStep,
    required this.totalSteps,
    required this.progressPercentage,
  });

  factory OnboardingProgressModel.fromJson(Map<String, dynamic> json) {
    return OnboardingProgressModel(
      flowId: json['flow_id'] as String,
      currentStep: json['current_step'] as int,
      totalSteps: json['total_steps'] as int,
      progressPercentage: (json['progress_percentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flow_id': flowId,
      'current_step': currentStep,
      'total_steps': totalSteps,
      'progress_percentage': progressPercentage,
    };
  }
}

/// Authentication response model
/// Used for both login and register responses
class AuthResponseModel {
  final String userId;
  final String accessToken;
  final String refreshToken;
  final bool onboardingRequired;
  final OnboardingProgressModel? onboardingProgress;
  final String? firebaseToken;
  final String? firebaseUid;

  AuthResponseModel({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
    required this.onboardingRequired,
    this.onboardingProgress,
    this.firebaseToken,
    this.firebaseUid,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      userId: json['user_id'] as String,
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      onboardingRequired: json['onboarding_required'] as bool,
      onboardingProgress: json['onboarding_progress'] != null
          ? OnboardingProgressModel.fromJson(
              json['onboarding_progress'] as Map<String, dynamic>,
            )
          : null,
      firebaseToken: json['firebase_token'] as String?,
      firebaseUid: json['firebase_uid'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'onboarding_required': onboardingRequired,
      'onboarding_progress': onboardingProgress?.toJson(),
      'firebase_token': firebaseToken,
      'firebase_uid': firebaseUid,
    };
  }
}

/// OTP verification response model
class OtpVerificationModel {
  final bool valid;
  final String? resetToken;
  final int? expiresIn;

  OtpVerificationModel({required this.valid, this.resetToken, this.expiresIn});

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) {
    return OtpVerificationModel(
      valid: json['valid'] as bool,
      resetToken: json['reset_token'] as String?,
      expiresIn: json['expires_in'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'valid': valid, 'reset_token': resetToken, 'expires_in': expiresIn};
  }
}

/// Password reset response model
class PasswordResetModel {
  final String message;
  final bool otpSent;

  PasswordResetModel({required this.message, required this.otpSent});

  factory PasswordResetModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetModel(
      message: json['message'] as String,
      otpSent: json['otp_sent'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'otp_sent': otpSent};
  }
}

/// User model
class UserModel {
  final String userId;
  final String? email;
  final String? phone;
  final bool isOnboardingComplete;
  final String profileStatus;
  final List<String> authProviders;
  final DateTime createdAt;

  UserModel({
    required this.userId,
    this.email,
    this.phone,
    required this.isOnboardingComplete,
    required this.profileStatus,
    required this.authProviders,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      isOnboardingComplete: json['is_onboarding_complete'] as bool,
      profileStatus: json['profile_status'] as String,
      authProviders: (json['auth_providers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'phone': phone,
      'is_onboarding_complete': isOnboardingComplete,
      'profile_status': profileStatus,
      'auth_providers': authProviders,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

/// Firebase custom token response model
class FirebaseTokenModel {
  final String? firebaseToken;
  final String firebaseUid;

  FirebaseTokenModel({required this.firebaseToken, required this.firebaseUid});

  factory FirebaseTokenModel.fromJson(Map<String, dynamic> json) {
    return FirebaseTokenModel(
      firebaseToken: json['firebase_token'] as String?,
      firebaseUid: json['firebase_uid'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'firebase_token': firebaseToken, 'firebase_uid': firebaseUid};
  }
}
