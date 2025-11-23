/// Response model for GET /onboarding/progress endpoint
class OnboardingProgressModel {
  final String userId;
  final String flowId;
  final OnboardingCurrentStepModel currentStep;
  final List<String> completedSteps;
  final List<String> skippedSteps;
  final double progressPercentage;
  final bool isComplete;

  OnboardingProgressModel({
    required this.userId,
    required this.flowId,
    required this.currentStep,
    required this.completedSteps,
    required this.skippedSteps,
    required this.progressPercentage,
    required this.isComplete,
  });

  factory OnboardingProgressModel.fromJson(Map<String, dynamic> json) {
    return OnboardingProgressModel(
      userId: json['user_id'] as String,
      flowId: json['flow_id'] as String,
      currentStep: OnboardingCurrentStepModel.fromJson(
        json['current_step'] as Map<String, dynamic>,
      ),
      completedSteps: (json['completed_steps'] as List)
          .map((e) => e as String)
          .toList(),
      skippedSteps: (json['skipped_steps'] as List)
          .map((e) => e as String)
          .toList(),
      progressPercentage: (json['progress_percentage'] as num).toDouble(),
      isComplete: json['is_complete'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'flow_id': flowId,
      'current_step': currentStep.toJson(),
      'completed_steps': completedSteps,
      'skipped_steps': skippedSteps,
      'progress_percentage': progressPercentage,
      'is_complete': isComplete,
    };
  }
}

/// Model for current onboarding step information
class OnboardingCurrentStepModel {
  final int stepNumber;
  final String stepId;
  final String name;
  final List<String> requiredFields;
  final bool skippable;

  OnboardingCurrentStepModel({
    required this.stepNumber,
    required this.stepId,
    required this.name,
    required this.requiredFields,
    required this.skippable,
  });

  factory OnboardingCurrentStepModel.fromJson(Map<String, dynamic> json) {
    return OnboardingCurrentStepModel(
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
