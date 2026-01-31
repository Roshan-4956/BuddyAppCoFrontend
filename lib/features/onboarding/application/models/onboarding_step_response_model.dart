/// Response model for POST /onboarding/step endpoint
class OnboardingStepResponseModel {
  final bool success;
  final OnboardingNextStepModel? nextStep;
  final double progressPercentage;

  // Fields present when onboarding is complete
  final String? profileStatus;
  final int? profileCompletionPercentage;
  final String? redirectTo;

  OnboardingStepResponseModel({
    required this.success,
    this.nextStep,
    required this.progressPercentage,
    this.profileStatus,
    this.profileCompletionPercentage,
    this.redirectTo,
  });

  factory OnboardingStepResponseModel.fromJson(Map<String, dynamic> json) {
    return OnboardingStepResponseModel(
      success: json['success'] as bool? ?? false,
      nextStep: json['next_step'] != null
          ? OnboardingNextStepModel.fromJson(
              json['next_step'] as Map<String, dynamic>,
            )
          : null,
      progressPercentage:
          (json['progress_percentage'] as num?)?.toDouble() ?? 0.0,
      profileStatus: json['profile_status'] as String?,
      profileCompletionPercentage:
          json['profile_completion_percentage'] as int?,
      redirectTo: json['redirect_to'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'next_step': nextStep?.toJson(),
      'progress_percentage': progressPercentage,
      'profile_status': profileStatus,
      'profile_completion_percentage': profileCompletionPercentage,
      'redirect_to': redirectTo,
    };
  }
}

class OnboardingNextStepModel {
  final int stepNumber;
  final String stepId;
  final String name;
  final List<String> requiredFields;
  final bool skippable;

  OnboardingNextStepModel({
    required this.stepNumber,
    required this.stepId,
    required this.name,
    required this.requiredFields,
    required this.skippable,
  });

  factory OnboardingNextStepModel.fromJson(Map<String, dynamic> json) {
    return OnboardingNextStepModel(
      stepNumber: json['step_number'] as int,
      stepId: json['step_id'] as String,
      name: json['name'] as String,
      requiredFields: (json['required_fields'] as List)
          .map((e) => e as String)
          .toList(),
      skippable: json['skippable'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'step_number': stepNumber,
      'step_id': stepId,
      'name': name,
      'required_fields': requiredFields,
      'skippable': skippable,
    };
  }
}
