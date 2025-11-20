import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screen_outline.dart';

class NotFoundScreen extends ConsumerWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScreenOutline(
      body: Center(
        child: Text('404\nScreen not Found', textAlign: TextAlign.center),
      ),
    );
  }
}
