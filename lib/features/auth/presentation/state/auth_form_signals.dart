import 'package:signals_flutter/signals_flutter.dart';

/// Manages the local state of the login/register forms using Signals.
/// This keeps form validation logic separate from the global AuthNotifier.
class AuthFormState {
  // Private constructor to prevent instantiation if used as a singleton,
  // but here we likely want transient instances or just static access if global.
  // For forms, a singleton or global signals are fine if reset, or we can just use top-level signals.
  // Given the screens are separate, let's use a class with static members or a singleton to scope them,
  // OR just top-level variables if they need to be shared.
  //
  // Better approach for forms: Create a controller instance per screen or share if needed.
  // Let's use a singleton-like pattern for simplicity in this context, or just top-level.
  // actually, let's make them scoped to a class that can be reset.
}

// ==============================================================================
// Signals
// ==============================================================================

final emailSignal = signal<String>('');
final passwordSignal = signal<String>('');
final phoneSignal = signal<String>('');
final obscurePasswordSignal = signal<bool>(true);

// ==============================================================================
// Computed Validators
// ==============================================================================

final emailErrorSignal = computed<String?>(() {
  final email = emailSignal.value;
  if (email.isEmpty) {
    return null;
  } // Don't show error while typing initially or empty?
  // Actually, usually we want to validate on demand or dirty.
  // For simplicity, let's validate if not empty.

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
  if (!emailRegex.hasMatch(email)) {
    return 'Enter valid email address';
  }
  return null;
});

final passwordErrorSignal = computed<String?>(() {
  final password = passwordSignal.value;
  if (password.isEmpty) return null;

  if (password.length < 8 || password.length > 15) {
    return 'Password must be 8-15 characters long';
  }

  final symbolRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  final numberRegex = RegExp(r'\d');
  final uppercaseRegex = RegExp(r'[A-Z]');

  if (!symbolRegex.hasMatch(password)) {
    return 'Password must contain at least one symbol';
  }
  if (!numberRegex.hasMatch(password)) {
    return 'Password must contain at least one number';
  }
  if (!uppercaseRegex.hasMatch(password)) {
    return 'Password must contain at least one uppercase letter';
  }
  return null;
});

final phoneErrorSignal = computed<String?>(() {
  final phone = phoneSignal.value;
  if (phone.isEmpty) return null;

  if (phone.length < 10) {
    return 'Enter valid phone number';
  }
  return null;
});

// ==============================================================================
// Validation Actions
// ==============================================================================

// We also need "dirty" state to know if we should show the error.
// Or we can just rely on the fact that if the user hits "Submit", we check the values.
final isEmailDirty = signal(false);
final isPasswordDirty = signal(false);
final isPhoneDirty = signal(false);

// Helper to reset form
void resetAuthForms() {
  emailSignal.value = '';
  passwordSignal.value = '';
  phoneSignal.value = '';
  obscurePasswordSignal.value = true;
  isEmailDirty.value = false;
  isPasswordDirty.value = false;
  isPhoneDirty.value = false;
}

// Helper to force validation display
bool validateEmailForm() {
  isEmailDirty.value = true;
  isPasswordDirty.value = true;
  return emailErrorSignal.value == null &&
      passwordErrorSignal.value == null &&
      emailSignal.value.isNotEmpty &&
      passwordSignal.value.isNotEmpty;
}

bool validatePhoneForm() {
  isPhoneDirty.value = true;
  return phoneErrorSignal.value == null && phoneSignal.value.isNotEmpty;
}
