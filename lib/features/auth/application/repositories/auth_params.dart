import '../../../../utils/api/implementation/simple_api/simple_params.dart';

/// Parameters for forgot password API endpoint
class ForgotPasswordParams extends SimpleParameters {
  String? email;

  /// Sets the email for password reset
  void setEmail(String email) {
    this.email = email;
    body = {'email': email};
  }

  @override
  void reset() {
    super.reset();
    email = null;
  }
}

/// Parameters for login API endpoint
class LoginParams extends SimpleParameters {
  String? email;
  String? phone;
  String? password;

  /// Sets the login credentials (email or phone + password)
  void setEmailLogin(String email, String password) {
    this.email = email;
    this.password = password;
    phone = null; // Clear phone if using email
    body = {'email': email, 'password': password};
  }

  void setPhoneLogin(String phone, String password) {
    this.phone = phone;
    this.password = password;
    email = null; // Clear email if using phone
    body = {'phone': phone, 'password': password};
  }

  @override
  void reset() {
    super.reset();
    email = null;
    phone = null;
    password = null;
  }
}

/// Parameters for register API endpoint
class RegisterParams extends SimpleParameters {
  String? email;
  String? password;

  /// Sets the registration credentials
  void setCredentials(String email, String password) {
    this.email = email;
    this.password = password;
    body = {'email': email, 'password': password};
  }

  @override
  void reset() {
    super.reset();
    email = null;
    password = null;
  }
}

/// Parameters for reset password API endpoint
class ResetPasswordParams extends SimpleParameters {
  String? email;
  String? resetToken;
  String? newPassword;

  /// Sets the credentials for password reset
  void setCredentials(String email, String resetToken, String newPassword) {
    this.email = email;
    this.resetToken = resetToken;
    this.newPassword = newPassword;
    body = {
      'email': email,
      'reset_token': resetToken,
      'new_password': newPassword,
    };
  }

  @override
  void reset() {
    super.reset();
    email = null;
    resetToken = null;
    newPassword = null;
  }
}

/// Parameters for OTP verification API endpoint
class VerifyOtpParams extends SimpleParameters {
  String? email;
  String? otp;

  /// Sets the email and OTP for verification
  void setCredentials(String email, String otp) {
    this.email = email;
    this.otp = otp;
    body = {'email': email, 'otp': otp};
  }

  @override
  void reset() {
    super.reset();
    email = null;
    otp = null;
  }
}
