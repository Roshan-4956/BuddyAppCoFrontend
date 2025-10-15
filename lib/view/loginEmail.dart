import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

final emailErrorProvider = StateProvider<String?>((ref) => null);
final pswdErrorProvider = StateProvider<String?>((ref) => null);

class loginEmail extends ConsumerStatefulWidget {
  loginEmail({super.key});

  @override
  ConsumerState<loginEmail> createState() => _loginEmail();
}

class _loginEmail extends ConsumerState<loginEmail> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pswdController = TextEditingController();
  void validateEmail() {
    final email = emailController.text;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');

    if (email.isEmpty) {
      ref.read(emailErrorProvider.notifier).state = 'Email is required';
    } else if (!emailRegex.hasMatch(email)) {
      ref.read(emailErrorProvider.notifier).state = 'Enter valid email address';
    } else {
      ref.read(emailErrorProvider.notifier).state = null;
    }
  }

  bool validatePassword() {
    final password = pswdController.text;
    final symbolRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    final numberRegex = RegExp(r'\d');
    final uppercaseRegex = RegExp(r'[A-Z]');

    if (password.isEmpty) {
      ref.read(pswdErrorProvider.notifier).state = 'Password is required';
      return false;
    } else if (password.length < 8 || password.length > 15) {
      ref.read(pswdErrorProvider.notifier).state =
          'Password must be 8-15 characters long';
      return false;
    } else if (!symbolRegex.hasMatch(password)) {
      ref.read(pswdErrorProvider.notifier).state =
          'Password must contain at least one symbol';
      return false;
    } else if (!numberRegex.hasMatch(password)) {
      ref.read(pswdErrorProvider.notifier).state =
          'Password must contain at least one number';
      return false;
    } else if (!uppercaseRegex.hasMatch(password)) {
      ref.read(pswdErrorProvider.notifier).state =
          'Password must contain at least one uppercase letter';
      return false;
    } else {
      ref.read(pswdErrorProvider.notifier).state = null;
      return true;
    }
  }

  void onSubmit() {
    if (validatePassword() && ref.watch(emailErrorProvider) == null) {
      // Navigate to next page if validation passes
      GoRouter.of(context).go('/emailOTP');
    }
  }

  Widget build(BuildContext context) {
    final errorText = ref.watch(emailErrorProvider);
    final pswdErrorText = ref.watch(pswdErrorProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/buddyLogoTitle.png", scale: 4),
        backgroundColor: Colors.white,

        leading: GestureDetector(
          onTap: () => GoRouter.of(context).go("/loginOptions"),
          child: Image.asset("assets/backArrow.png", scale: 3),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Center(
            child: Text(
              "Let's get started",
              style: TextStyle(
                fontFamily: "Rethink Sans",
                fontSize: 36,
                fontVariations: [
                  FontVariation(
                    'wght',
                    1000,
                  ), // Set weight to 1000 if supported
                ],
                color: Color(0xFF555555),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 2.5)),
          Center(
            child: Text(
              "Enter your email address\n and password",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Rethink Sans",
                fontSize: 16,
                fontWeight: FontWeight.w600, // Set weight to 1000 if supported
                color: Color(0xFF8793A1),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter Email Address",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Rethink Sans",
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w600, // Set weight to 1000 if supported
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: emailController,
              cursorColor: Color(0xFF1E1E1E), // Cursor color
              style: TextStyle(
                color: Color(0xFF8793A1),
                fontFamily: "Rethink Sans",
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ), // Text color
              decoration: InputDecoration(
                hintText: 'youremail@email.com',
                hintStyle: TextStyle(
                  color: Color(0xFF8793A1),
                  fontFamily: "Rethink Sans",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ), // Label text color
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                validateEmail();
              },
            ),
          ),
          if (errorText != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Image.asset("assets/login_screen/error.png", scale: 4),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
                    Text(
                      errorText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Rethink Sans",
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w600, // Set weight to 1000 if supported
                        color: Color(0xFFBC1010),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Rethink Sans",
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w600, // Set weight to 1000 if supported
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              obscureText: true, // Hides the input
              obscuringCharacter: '•',
              controller: pswdController,
              cursorColor: Color(0xFF1E1E1E), // Cursor color
              style: TextStyle(
                color: Color(0xFF8793A1),
                fontFamily: "Rethink Sans",
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ), // Text color
              decoration: InputDecoration(
                hintText: 'Enter here',
                hintStyle: TextStyle(
                  color: Color(0xFF8793A1),
                  fontFamily: "Rethink Sans",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ), // Label text color
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                validatePassword();
              },
            ),
          ),
          if (pswdErrorText != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Image.asset("assets/login_screen/error.png", scale: 4),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
                    Text(
                      pswdErrorText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Rethink Sans",
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w600, // Set weight to 1000 if supported

                        color: Color(0xFFBC1010),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          GestureDetector(
            onTap: () => onSubmit(),
            child: Container(
              width: (MediaQuery.of(context).size.width) - 30,
              height: 55,
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: Center(
                child: const Text(
                  'Login/Sign up',
                  style: TextStyle(
                    fontFamily: "Rethink Sans",
                    color: Color(0xFFF6DDE1),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
