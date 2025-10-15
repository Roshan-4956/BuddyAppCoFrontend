import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../view/home_screen/nudge.dart';


class NudgeSelector extends ConsumerWidget {
  const NudgeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(nudgeTabProvider);
    final options = ["Explore Nudges", "My Nudges", "Sent Nudges"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(options.length, (index) {
        final isSelected = selectedIndex == index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: GestureDetector(
            onTap: () {
              ref.read(nudgeTabProvider.notifier).state = index;
            },
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFFF6DDE1) : Color(0x52F6DDE1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFFF6DDE1),
                  width: 1.5,
                ),
              ),
              child: Text(
                options[index],
                style: TextStyle(
                  fontFamily: "Rethink Sans",
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}