import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

import '../constants/interest_tiles_data.dart';

final myInterestsProvider = StateProvider.autoDispose<List<int>>((ref) => []);

class interestCapture extends ConsumerStatefulWidget {
  const interestCapture({super.key});

  @override
  ConsumerState<interestCapture> createState() => _interestCapture();
}

class _interestCapture extends ConsumerState<interestCapture> {
  final List<List<int>> rows = [
    [0, 1], // Row 1
    [2, 3], // Row 2
    [4, 5, 6], // Row 3
    [7, 8], // Row 4
    [9, 10], // Row 5
    [11], // Row 6
  ];
  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(myInterestsProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/buddyLogoTitle.png", scale: 4),
        backgroundColor: Colors.white,

        // leading: GestureDetector(
        //   onTap: () => GoRouter.of(context).go("/loginPhone"),
        //   child: Image.asset("assets/backArrow.png", scale: 3,),
        // )
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Center(
                child: Text(
                  "Select your interest",
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
                  "Pick up to 3 things you love most",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Rethink Sans",
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w600, // Set weight to 1000 if supported
                    color: Color(0xFF8793A1),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 25)),

              ...rows.map(
                (rowIndexes) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...rowIndexes.map((i) {
                        final isSelected = selected.contains(i);

                        // Unselected: pink bg, dark pink border
                        final unselectedBg = Color(0x54F6DDE1);
                        final unselectedBorder = Color(0xFFF6DDE1);

                        // If selected, use tile's own colors
                        final tile = interestTiles[i];
                        final bgColor = isSelected
                            ? tile.selectedBg
                            : unselectedBg;
                        final borderColor = isSelected
                            ? tile.selectedBorder
                            : unselectedBorder;
                        final textColor = isSelected
                            ? Colors.black
                            : Colors.black;

                        return GestureDetector(
                          onTap: () {
                            final current = List<int>.from(selected);
                            if (isSelected) {
                              current.remove(i);
                            } else if (current.length < 3) {
                              current.add(i);
                            }
                            ref.read(myInterestsProvider.notifier).state =
                                current;
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 160),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.symmetric(horizontal: 7),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: bgColor,
                              border: Border.all(
                                color: borderColor,
                                width: 2.4,
                              ),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Row(
                              children: [
                                Image.asset(tile.iconPath, scale: 4),
                                SizedBox(width: 9),
                                Text(
                                  tile.title,
                                  style: TextStyle(
                                    fontFamily: "Rethink Sans",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 90,
            child: GestureDetector(
              onTap: () => GoRouter.of(context).go('/buddyCommunitySelector'),
              child: Container(
                width: (MediaQuery.of(context).size.width) - 30,
                height: 55,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                child: Center(
                  child: const Text(
                    'Continue',
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
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
