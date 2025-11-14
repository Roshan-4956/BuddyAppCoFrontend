import 'package:buddy_app/old/Widgets/appBar.dart';
import 'package:buddy_app/old/Widgets/navBar.dart';
import 'package:buddy_app/old/view/home_screen/pageList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final List<_NavItem> items = const [
  _NavItem("assets/homepage/homeNav.png", "Home"),
  _NavItem("assets/homepage/commNav.png", "Community"),
  _NavItem("assets/homepage/nudgeIcon.png", "Nudge"),
  _NavItem("assets/homepage/messageNav.png", "Messages"),
  _NavItem("assets/homepage/eventNav.png", "Events"),
];

class BottomNavIndex extends StateNotifier<int> {
  BottomNavIndex() : super(0);

  void setIndex(int idx) => state = idx;
}

final bottomNavProvider = StateNotifierProvider<BottomNavIndex, int>(
  (ref) => BottomNavIndex(),
);

class homepage extends ConsumerWidget {
  // final User user;
  final int? landingIndex;

  const homepage({super.key, this.landingIndex});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);
    if (landingIndex != null &&
        ref.read(bottomNavProvider.notifier).state == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(bottomNavProvider.notifier).state = landingIndex!;
      });
    }
    return Scaffold(
      appBar: appBarr(Name: "Sakshi", Location: "Thiruvananthapuram"),
      body: pages[selectedIndex],
      bottomNavigationBar: navBar(),
      backgroundColor: Colors.white,
    );
  }
}

class _NavItem {
  final String icon;
  final String label;
  const _NavItem(this.icon, this.label);
}
