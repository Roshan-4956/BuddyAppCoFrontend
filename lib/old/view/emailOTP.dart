import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class emailOTP extends ConsumerWidget {
  // final User user;

  const emailOTP({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/buddyLogoTitle.png", scale: 4),
        backgroundColor: Colors.white,

        leading: GestureDetector(
          onTap: () => GoRouter.of(context).go("/loginEmail"),
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
              "Account Verification",
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
              "An OTP has been sent to your email\naddress. Please enter it below.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Rethink Sans",
                fontSize: 16,
                fontWeight: FontWeight.w600, // Set weight to 1000 if supported
                color: Color(0xFF8793A1),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 25)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 50,
                fieldWidth: 50,
                activeFillColor: Color(0xFFFAFAFA),
                inactiveFillColor: Color(0xFFFAFAFA),
                selectedFillColor: Color(0xFFFAFAFA),
                activeColor: Color(0xFFF6DDE1),
                inactiveColor: Color(0xFFD7DBE0),
                selectedColor: Color(0xFFD7DBE0),
              ),
              cursorColor: Colors.black,
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              textStyle: TextStyle(
                fontFamily: 'Rethink Sans', // Set the custom font here
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1E1E1E),
              ),
              onChanged: (value) {
                print('OTP: $value');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Resend OTP',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                  color: Color(0xFF8793A1),
                  fontFamily: "Rethink Sans",
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          GestureDetector(
            onTap: () => GoRouter.of(context).go('/greenSplash'),
            child: Container(
              width: (MediaQuery.of(context).size.width) - 30,
              height: 55,
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: Center(
                child: const Text(
                  'Verify',
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
