import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

import '../constants/interest_tiles_data.dart';

class buddyCommunitySelector extends ConsumerStatefulWidget {
  const buddyCommunitySelector({super.key});

  @override
  ConsumerState<buddyCommunitySelector> createState() => _interestCapture();
}

class _interestCapture extends ConsumerState<buddyCommunitySelector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/buddyLogoTitle.png", scale: 4),
        backgroundColor: Colors.white,

        // leading: GestureDetector(
        //   onTap: () => GoRouter.of(context).go("/loginPhone"),
        //   child: Image.asset("assets/backArrow.png", scale: 3),
        // ),
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
                  "What would you\nwant to do first?",
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
              Padding(padding: EdgeInsets.symmetric(vertical: 17.5)),
              GestureDetector(
                onTap: () => GoRouter.of(context).go('/loginPhone'),
                child: Container(
                  width: (MediaQuery.of(context).size.width) - 70,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Color(0xFF8D8DFF),
                    borderRadius: BorderRadius.circular(16), // Rounded corners
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Become a Buddy',
                            style: TextStyle(
                              fontFamily: "Rethink Sans",
                              color: Colors.white,
                              fontVariations: [
                                FontVariation(
                                  'wght',
                                  1000,
                                ), // Set weight to 1000 if supported
                              ],
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            'you can become a buddy and\nhelp individuals find best places\nto explore',
                            style: TextStyle(
                              fontFamily: "Rethink Sans",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              GestureDetector(
                onTap: () => GoRouter.of(context).go('/homepage'),
                child: Container(
                  width: (MediaQuery.of(context).size.width) - 70,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6D307),
                    borderRadius: BorderRadius.circular(16), // Rounded corners
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Find a Buddy',
                            style: TextStyle(
                              fontFamily: "Rethink Sans",
                              color: Colors.white,
                              fontVariations: [
                                FontVariation(
                                  'wght',
                                  1000,
                                ), // Set weight to 1000 if supported
                              ],
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            'you can find a buddy and help\nindividuals find best places to\nexplore',
                            style: TextStyle(
                              fontFamily: "Rethink Sans",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              GestureDetector(
                onTap: () => GoRouter.of(context).go('/loginPhone'),
                child: Container(
                  width: (MediaQuery.of(context).size.width) - 70,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Color(0xFF64BDFF),
                    borderRadius: BorderRadius.circular(16), // Rounded corners
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore Community',
                            style: TextStyle(
                              fontFamily: "Rethink Sans",
                              color: Colors.white,
                              fontVariations: [
                                FontVariation(
                                  'wght',
                                  1000,
                                ), // Set weight to 1000 if supported
                              ],
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            'you can explore community\n& attend event and find best\nplaces to explore',
                            style: TextStyle(
                              fontFamily: "Rethink Sans",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 25,
              top: 130,
              child: Image.asset('assets/purpStars.png', scale: 4,)),
          Positioned(
              left: 25,
              top: 270,
              child: Image.asset('assets/purpStar.png', scale: 4,)),
          Positioned(
              right: 25,
              top: 440,
              child: Image.asset('assets/yellowStar.png', scale: 4,)),
          Positioned(
              left: 25,
              top: 600,
              child: Image.asset('assets/blueStars.png', scale: 4,)),
          Positioned(
              right: 55,
              top: 170,
              child: Image.asset('assets/ladderClimber.png', scale: 4,)),
          Positioned(
              right: 43,
              top: 527,
              child: Image.asset('assets/commPeeps.png', scale: 4,)),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
