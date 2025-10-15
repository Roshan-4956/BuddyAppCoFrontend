import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends ConsumerWidget {
  // final User user;

  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              child: Image.asset('assets/login_screen/welcomescreen.png'),
              fit: BoxFit.fitWidth,
            ),
          ),

          Positioned(
            top: ((MediaQuery.of(context).size.height)*2 / 3)-10,
            left: 30,
            right: 30,
            // left: ((MediaQuery.of(context).size.width) / 2),
            child: Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text("Welcome to Buddy", style: TextStyle(fontFamily: "Rethink Sans", fontSize: 28, fontWeight: FontWeight.w900, )
                            ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Text("Find buddies, become a buddy,\nand belong to communities", textAlign: TextAlign.center,style: TextStyle(fontFamily: "Rethink Sans", fontSize: 16, fontWeight: FontWeight.w600,  )
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 50)),
                    GestureDetector(
                      onTap: () => GoRouter.of(context).go('/loginOptions'),
                      child: Container(
                        width: 240,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(20), // Rounded corners
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [const Text(
                              'Get started',
                              style: TextStyle(fontFamily:"Rethink Sans",color: Color(0xFFF6DDE1), fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                            Image.asset("assets/login_screen/arrow.png", scale: 4,)
                            ]
                          ),
                        ),
                      ),
                    )
                  ]
                ),
              ),
            ),)



        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
