import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class loginPhone extends ConsumerWidget {
  // final User user;

  const loginPhone({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/buddyLogoTitle.png", scale: 4,),
        backgroundColor: Colors.white,

          leading: GestureDetector(
            onTap: () => GoRouter.of(context).go("/loginOptions"),
            child: Image.asset("assets/backArrow.png", scale: 3,),
          )

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Center(
            child: Text("Let's get started", style: TextStyle(fontFamily: "Rethink Sans", fontSize: 36, fontVariations: [
              FontVariation('wght', 1000), // Set weight to 1000 if supported
            ], color: Color(0xFF555555) )
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 2.5)),
          Center(
            child: Text("Enter your phone number", style: TextStyle(fontFamily: "Rethink Sans", fontSize: 16,fontWeight: FontWeight.w600, // Set weight to 1000 if supported
             color: Color(0xFF8793A1) )
            ),
          ),
            Padding(padding: EdgeInsets.symmetric(vertical: 25)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: IntlPhoneField(
              cursorColor: Color(0xFF1E1E1E),
              decoration: InputDecoration(
                labelText: 'Enter Phone Number',
                labelStyle: TextStyle(color: Color(0xFF1E1E1E),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                ),
                focusColor: Color(0xFFF6DDE1),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                print('Phone number: ${phone.completeNumber}');
              },
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          GestureDetector(
            onTap: () => GoRouter.of(context).go('/phoneOTP'),
            child: Container(
              width: (MediaQuery.of(context).size.width)-30,
              height: 55,
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: Center(
                child: const Text(
                  'Send OTP',
                  style: TextStyle(fontFamily:"Rethink Sans",color: Color(0xFFF6DDE1), fontWeight: FontWeight.w600, fontSize: 16),
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
