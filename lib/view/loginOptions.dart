import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class loginOptions extends ConsumerWidget {
  // final User user;

  const loginOptions({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              child: Image.asset('assets/login_screen/loginOptions.png', scale: 4,),
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
              bottom: 40,
              left:15,
              right: 15,
              child: Container(
                width: (MediaQuery.of(context).size.width)-30,
                height: ((MediaQuery.of(context).size.height)*2 / 5)-40,
                decoration: BoxDecoration(
                  color: Color(0xFFF6DDE1),
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Sign in", style: TextStyle(fontFamily: "Rethink Sans", fontSize: 28, fontWeight: FontWeight.w900, )),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      GestureDetector(
                        onTap: () => GoRouter.of(context).go('/loginPhone'),
                        child: Container(
                          width: (MediaQuery.of(context).size.width)-60,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(20), // Rounded corners
                          ),
                          child: Center(
                            child: const Text(
                                  'Continue with phone',
                                  style: TextStyle(fontFamily:"Rethink Sans",color: Color(0xFFF6DDE1), fontWeight: FontWeight.w600, fontSize: 16),
                                ),


                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 2.5)),
                      GestureDetector(
                        onTap: () => GoRouter.of(context).go('/loginEmail'),
                        child: Container(
                          width: (MediaQuery.of(context).size.width)-60,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20), // Rounded corners
                          ),
                          child: Center(
                            child: const Text(
                                  'Continue with email',
                                  style: TextStyle(fontFamily:"Rethink Sans",color: Color(0xFF1E1E1E), fontWeight: FontWeight.w600, fontSize: 16),
                                ),


                            ),
                          ),
                        ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 2.5)),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => GoRouter.of(context).go('/greenSplash'),
                            child: Container(
                              width: (MediaQuery.of(context).size.width/2)-37.5,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20), // Rounded corners
                              ),
                              child: Center(
                                child: Image.asset('assets/login_screen/apple.png', scale: 4,),


                              ),
                            ),
                          ),Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
                          GestureDetector(
                            onTap: () => GoRouter.of(context).go('/greenSplash'),
                            child: Container(
                              width: (MediaQuery.of(context).size.width/2)-37.5,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20), // Rounded corners
                              ),
                              child: Center(
                                child: Image.asset('assets/login_screen/google.png', scale: 4,),


                              ),
                            ),
                          ),
                        ],
                      )


                    ],
                  ),
                )
              ),
          ),




        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
