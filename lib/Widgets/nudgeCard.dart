import 'package:flutter/material.dart';

import 'package:flip_card/flip_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../constants/nudge_model.dart';

class ExploreNudgesPage extends StatefulWidget {
  final List<Nudge> nudges;
  const ExploreNudgesPage({super.key, required this.nudges});

  @override
  State<ExploreNudgesPage> createState() => _ExploreNudgesPageState();
}

class _ExploreNudgesPageState extends State<ExploreNudgesPage> {
  late MatchEngine _matchEngine;
  final List<SwipeItem> _swipeItems = [];

  @override
  void initState() {
    super.initState();

    for (var nudge in widget.nudges) {
      _swipeItems.add(SwipeItem(
        content: nudge,
        likeAction: () {
          debugPrint("👍 Liked ${nudge.title}");
        },
        nopeAction: () {
          debugPrint("👎 Skipped ${nudge.title}");
        },
        superlikeAction: () {
          debugPrint("⭐ Superliked ${nudge.title}");
        },
      ));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SwipeCards(
        matchEngine: _matchEngine,
        itemBuilder: (context, index) {
          final nudge = widget.nudges[index];
          return FlipCard(
            direction: FlipDirection.HORIZONTAL, // tap flip left/right
            front: _buildFrontCard(nudge),
            back: _buildBackCard(nudge),
          );
        },
        onStackFinished: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("🎉 No more nudges")),
          );
        },
        itemChanged: (item, index) {
          debugPrint("Now showing: ${item.content.title}");
        },
        upSwipeAllowed: true,
        fillSpace: true,
      ),
    );
  }

  Widget _buildFrontCard(Nudge nudge) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Expanded(
          child: Stack(
            children: [
              Image.asset("assets/nudges/card.png", scale: 4,),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 122,),
                    Text(
                      "${nudge.title}",
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: "Rethink Sans",
                        fontVariations: [
                          FontVariation("wght", 1200),

                        ],
                        color: Color(0xffE769CE)
                      ),
                    ),
                    SizedBox(height: 17,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/nudges/locPin.png", scale: 4,),
                        SizedBox(width: 10,),
                        Text("${nudge.location}",
                          style: TextStyle(
                            fontFamily: "Rethink Sans",
                            fontSize: 12,
                            fontVariations: [
                              FontVariation("wght", 1000)
                            ]

                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 160,),

                    Text("posted by",
                      style: TextStyle(
                          fontFamily: "Rethink Sans",
                          fontSize: 10,
                          fontVariations: [
                            FontVariation("wght", 900)
                          ]

                      ),
                    ),
                    Text("${nudge.postedBy}",
                      style: TextStyle(
                          fontFamily: "Rethink Sans",
                          fontSize: 16,
                          fontVariations: [
                            FontVariation("wght", 1000)
                          ]

                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackCard(Nudge nudge) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Expanded(
          child: Stack(
            children: [
              Image.asset("assets/nudges/card.png", scale: 4,),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child: Row(
                          children: [

                            Image.asset("assets/nudges/calPin.png", scale: 4,),
                            SizedBox(width: 10,),
                            Text("${nudge.dateTime.day}/${nudge.dateTime.month}/${nudge.dateTime.year}",
                              style: TextStyle(
                                  fontFamily: "Rethink Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                            Expanded(child: Container(),),
                            Image.asset("assets/nudges/peoplePin.png", scale: 4,),
                            SizedBox(width: 10,),
                            Text("${nudge.attendeesCount}",
                              style: TextStyle(
                                  fontFamily: "Rethink Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(child: Container(),),
                      SizedBox(
                        height: 117,
                        child: Text("${nudge.description}",
                          style: TextStyle(
                              fontFamily: "Rethink Sans",
                              fontSize: 16,
                              fontVariations: [
                                FontVariation("wght", 900)
                              ]

                          ),
                        ),
                      ),
                      SizedBox(height: 85,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child: Row(

                          children: [
                            Image.asset("assets/nudges/timePin.png", scale: 4,),
                            SizedBox(width: 10,),
                            Text("${nudge.dateTime.hour}:${nudge.dateTime.minute} PM",
                              style: TextStyle(
                                fontFamily: "Rethink Sans",
                                fontSize: 12,
                                fontWeight: FontWeight.w900
                              ),
                            ),
                            Expanded(child: Container(),),
                            Image.asset("assets/nudges/starPin.png", scale: 4,),
                            SizedBox(width: 10,),
                            Text("${nudge.category}",
                              style: TextStyle(
                                  fontFamily: "Rethink Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: (MediaQuery.of(context).size.width)-180,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(20), // Rounded corners
                        ),
                        child: Center(
                          child: const Text(
                            'Request',
                            style: TextStyle(fontFamily:"Rethink Sans",color: Color(0xFFF6DDE1), fontWeight: FontWeight.w600, fontSize: 16),
                          ),


                        ),
                      ),
                      SizedBox(height: 50,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
