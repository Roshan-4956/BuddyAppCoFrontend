import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../view/home_screen/homepage.dart';



class navBar extends ConsumerWidget {
  const navBar({Key? key}) : super(key: key);
  void updateNavAndGo(BuildContext context, WidgetRef ref, int index, ) {
    // 1. Update provider state
    ref.read(bottomNavProvider.notifier).setIndex(index);

    // 2. Navigate with GoRouter
    GoRouter.of(context).go("/homepage");
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -2),
              blurRadius: 12,
            )
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (i) {
            final isSelected = i == selectedIndex;
            return Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => updateNavAndGo(context, ref, i),
                child: Container(
                  width: 72, // fixed width so all items align perfectly
                  // no extra horizontal padding for selected now
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected)
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(items[i].icon, scale: 4, color: Color(0xFF1E1E1E)),
                              SizedBox(height: 6),
                              Text(
                                items[i].label,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 10,
                                    fontFamily: "Rethink Sans"
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Column(
                          children: [
                            Image.asset(items[i].icon, scale: 4, color: Color(0xFF8793A1)),
                            SizedBox(height: 6),
                            Text(
                              items[i].label,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8793A1),
                                  fontSize: 10,
                                  fontFamily: "Rethink Sans"
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

