import '../../../auth/application/models/auth_models.dart';

/// Response model for POST /onboarding/step endpoint
class OnboardingStepResponseModel {
  final String message;
  final OnboardingProgressModel progress;

  OnboardingStepResponseModel({required this.message, required this.progress});

  factory OnboardingStepResponseModel.fromJson(Map<String, dynamic> json) {
    return OnboardingStepResponseModel(
      message: json['message'] as String,
      progress: OnboardingProgressModel.fromJson(
        json['progress'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'progress': progress.toJson()};
  }
}
