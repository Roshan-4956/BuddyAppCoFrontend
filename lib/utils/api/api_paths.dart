/// Centralized API endpoint paths (relative to /api/v1).
class ApiPaths {
  // Auth
  static const String authBase = 'auth';
  static const String authLogin = '$authBase/login';
  static const String authRegisterEmail = '$authBase/register/email';
  static const String authMe = '$authBase/me';
  static const String authForgotPassword = '$authBase/forgot-password';
  static const String authVerifyOtp = '$authBase/verify-otp';
  static const String authResetPassword = '$authBase/reset-password';
  static const String authFirebaseToken = '$authBase/firebase-token';

  // Onboarding
  static const String onboardingBase = 'onboarding';
  static const String onboardingProgress = '$onboardingBase/progress';
  static const String onboardingStep = '$onboardingBase/step';
  static const String onboardingSkip = '$onboardingBase/skip';
  static const String onboardingComplete = '$onboardingBase/complete';

  // Static data
  static const String staticBase = 'static';
  static const String staticStates = '$staticBase/states';
  static const String staticCities = '$staticBase/cities';
  static const String staticOccupations = '$staticBase/occupations';
  static const String staticGenders = '$staticBase/genders';
  static const String staticInterests = '$staticBase/interests';
  static const String staticFlows = '$staticBase/flows';

  // Profile
  static const String profileBase = 'profile';
  static const String profileQuestions = '$profileBase/questions';
  static const String profileAnswers = '$profileBase/answers';
  static const String profileCompletion = '$profileBase/completion';
  static const String profileMe = '$profileBase/me';
}
