import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class greenSplash extends ConsumerStatefulWidget {
  // final User user;

  const greenSplash({super.key});
  @override
  ConsumerState<greenSplash> createState() => _greenSplash();
}

class _greenSplash extends ConsumerState<greenSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      context.go('/onBoarding'); // Navigate to your target route
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.asset('assets/greenSplash.png'),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
