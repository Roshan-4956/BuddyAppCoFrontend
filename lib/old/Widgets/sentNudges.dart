import 'package:flutter/material.dart';

import '../constants/nudge_model.dart';

class SentNudgesPage extends StatelessWidget {
  final List<Nudge> sentNudges;

  const SentNudgesPage({super.key, required this.sentNudges});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 67),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 25,
              offset: Offset(0, -4),
            ),
          ],
        ),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "You can unsend the below requests until they’re accepted",
                  style: TextStyle(
                    fontFamily: "Rethink Sans",
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff8793A1),
                  ),
                ),
              ),
              ListView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // disable nested scroll

                itemCount: sentNudges.length,
                itemBuilder: (context, index) {
                  final nudge = sentNudges[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nudge.title,
                                  style: TextStyle(
                                    fontFamily: "Rethink Sans",
                                    fontSize: 16,
                                    fontVariations: [
                                      FontVariation("wght", 1000),
                                    ],
                                    color: Color(0xff1e1e1e),
                                  ),
                                ),

                                Text(
                                  "Posted by ${nudge.postedBy}",
                                  style: TextStyle(
                                    fontFamily: "Rethink Sans",
                                    fontSize: 10,
                                    fontVariations: [
                                      FontVariation("wght", 900),
                                    ],
                                    color: Color(0xff8793A1),
                                  ),
                                ),

                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/nudges/locWOBG.png",
                                      scale: 4,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      nudge.location,
                                      style: TextStyle(
                                        fontFamily: "Rethink Sans",
                                        fontSize: 10,
                                        fontVariations: [
                                          FontVariation("wght", 900),
                                        ],
                                        color: Color(0xff8793A1),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/nudges/calWOBG.png",
                                      scale: 4,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "${nudge.dateTime.day} ${nudge.dateTime.month} ${nudge.dateTime.year}",
                                      style: TextStyle(
                                        fontFamily: "Rethink Sans",
                                        fontSize: 10,
                                        fontVariations: [
                                          FontVariation("wght", 900),
                                        ],
                                        color: Color(0xff8793A1),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/nudges/locWOBG.png",
                                      scale: 4,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "${nudge.dateTime.hour} ${nudge.dateTime.minute} P.M.",
                                      style: TextStyle(
                                        fontFamily: "Rethink Sans",
                                        fontSize: 10,
                                        fontVariations: [
                                          FontVariation("wght", 900),
                                        ],
                                        color: Color(0xff8793A1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/nudges/requestors.png",
                                      scale: 4,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "${nudge.attendeesCount}",
                                      style: TextStyle(
                                        fontFamily: "Rethink Sans",
                                        fontSize: 10,
                                        fontVariations: [
                                          FontVariation("wght", 1000),
                                        ],
                                        color: Color(0xff1e1e1e),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 23),
                                nudge.status == "Accepted"
                                    ? Image.asset(
                                        "assets/nudges/cross.png",
                                        scale: 4,
                                        color: Colors.transparent,
                                      )
                                    : Image.asset(
                                        "assets/nudges/cross.png",
                                        scale: 4,
                                      ),
                                SizedBox(height: 23),
                                Text(
                                  nudge.status,
                                  style: TextStyle(
                                    fontFamily: "Rethink Sans",
                                    fontSize: 10,
                                    fontVariations: [
                                      FontVariation("wght", 1000),
                                    ],
                                    color: Color(0xff424242),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
