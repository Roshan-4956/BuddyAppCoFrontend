import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants/nudge_model.dart';

class MyNudgesPage extends StatelessWidget {
  final List<NudgeRequests> ongoingNudges;
  final List<NudgeRequests> expiredNudges;

  const MyNudgesPage({
    super.key,
    required this.ongoingNudges,
    required this.expiredNudges,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 67),
      child: Container(
        height: double.infinity,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 17, 16, 17),
                child: Text(
                  "Ongoing Nudges:",
                  style: TextStyle(
                    fontFamily: "Rethink Sans",
                    fontSize: 12,
                    fontVariations: [FontVariation("wght", 1000)],
                    color: Color(0xFF1e1e1e),
                  ),
                ),
              ),

              ListView.builder(
                itemCount: ongoingNudges.length,
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // disable nested scroll
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final nudge = ongoingNudges[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Container(
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
                        padding: EdgeInsets.symmetric(vertical: 9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "${nudge.title}",
                                      style: TextStyle(
                                        fontFamily: "Rethink Sans",
                                        fontSize: 16,
                                        fontVariations: [
                                          FontVariation("wght", 1000),
                                        ],
                                        color: Color(0xFF1e1e1e),
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Image.asset(
                                    "assets/nudges/requestors.png",
                                    scale: 4,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${nudge.attendeesCount}",
                                    style: TextStyle(
                                      fontFamily: "Rethink Sans",
                                      fontSize: 10,
                                      fontVariations: [
                                        FontVariation("wght", 1000),
                                      ],
                                      color: Color(0xFF1e1e1e),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Theme(
                              data: Theme.of(context).copyWith(
                                dividerColor: Colors.transparent,
                                visualDensity: VisualDensity.compact,
                              ),
                              child: ListTileTheme(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ), // removes extra padding
                                dense: true,
                                child: ExpansionTile(
                                  tilePadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 0,
                                  ),
                                  title: Text(
                                    "${nudge.requests.length} people responded",
                                    style: TextStyle(
                                      fontFamily: "Rethink Sans",
                                      fontSize: 10,
                                      color: Color(0xFF8793A1),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  children: nudge.requests.map((nudge) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Container(
                                        height: 80,
                                        padding: EdgeInsets.all(11),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16),
                                          ),
                                          border: Border.all(
                                            color: Color(0xFFF6DDE1),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "${nudge.pic}",
                                              scale: 4,
                                            ),
                                            SizedBox(width: 6),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 6,
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${nudge.name}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Rethink Sans",
                                                          fontSize: 12,
                                                          fontVariations: [
                                                            FontVariation(
                                                              "wght",
                                                              1000,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 6,
                                                              vertical: 2,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                            0xffF6D307,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                Radius.circular(
                                                                  20,
                                                                ),
                                                              ),
                                                        ),
                                                        child: Text(
                                                          "Age ${nudge.age}",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Rethink Sans",
                                                            fontSize: 6,
                                                            fontVariations: [
                                                              FontVariation(
                                                                "wght",
                                                                1000,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                SizedBox(
                                                  height: 24,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        nudge.interests.length,
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(), // disable nested scroll

                                                    itemBuilder: (context, index) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 2,
                                                            ),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(6),
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    16,
                                                                  ),
                                                                ),
                                                            border: Border.all(
                                                              color: Color(
                                                                0xFFF6DDE1,
                                                              ),
                                                              width: 1.5,
                                                            ),
                                                            color: Color(
                                                              0x54F6DDE1,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                "${nudge.interests[index].iconAsset}",
                                                                scale: 4,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "${nudge.interests[index].name}",
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      "Rethink Sans",
                                                                  fontSize: 6,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(child: Container()),
                                            Column(
                                              children: [
                                                Image.asset(
                                                  "assets/nudges/tick.png",
                                                  scale: 4,
                                                ),
                                                SizedBox(height: 30),
                                                Image.asset(
                                                  "assets/nudges/cross.png",
                                                  scale: 4,
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 7),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              
              Padding(
                padding: EdgeInsets.fromLTRB(16, 17, 16, 17),
                child: Text(
                  "Expired Nudges:",
                  style: TextStyle(
                    fontFamily: "Rethink Sans",
                    fontSize: 12,
                    fontVariations: [FontVariation("wght", 1000)],
                    color: Color(0xFF1e1e1e),
                  ),
                ),
              ),

              ListView.builder(
                itemCount: expiredNudges.length,
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // disable nested scroll
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final nudge = expiredNudges[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Container(
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
                        padding: EdgeInsets.symmetric(vertical: 9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "${nudge.title}",
                                      style: TextStyle(
                                        fontFamily: "Rethink Sans",
                                        fontSize: 16,
                                        fontVariations: [
                                          FontVariation("wght", 1000),
                                        ],
                                        color: Color(0xFF1e1e1e),
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Image.asset(
                                    "assets/nudges/requestors.png",
                                    scale: 4,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${nudge.attendeesCount}",
                                    style: TextStyle(
                                      fontFamily: "Rethink Sans",
                                      fontSize: 10,
                                      fontVariations: [
                                        FontVariation("wght", 1000),
                                      ],
                                      color: Color(0xFF1e1e1e),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Theme(
                              data: Theme.of(context).copyWith(
                                dividerColor: Colors.transparent,
                                visualDensity: VisualDensity.compact,
                              ),
                              child: ListTileTheme(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ), // removes extra padding
                                dense: true,
                                child: ExpansionTile(
                                  tilePadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 0,
                                  ),
                                  title: Text(
                                    "${nudge.requests.length} people responded",
                                    style: TextStyle(
                                      fontFamily: "Rethink Sans",
                                      fontSize: 10,
                                      color: Color(0xFF8793A1),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  children: nudge.requests.map((nudge) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Container(
                                        height: 80,
                                        padding: EdgeInsets.all(11),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16),
                                          ),
                                          border: Border.all(
                                            color: Color(0xFFF6DDE1),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "${nudge.pic}",
                                              scale: 4,
                                            ),
                                            SizedBox(width: 6),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 6,
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${nudge.name}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Rethink Sans",
                                                          fontSize: 12,
                                                          fontVariations: [
                                                            FontVariation(
                                                              "wght",
                                                              1000,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 6,
                                                              vertical: 2,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                            0xffF6D307,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                Radius.circular(
                                                                  20,
                                                                ),
                                                              ),
                                                        ),
                                                        child: Text(
                                                          "Age ${nudge.age}",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Rethink Sans",
                                                            fontSize: 6,
                                                            fontVariations: [
                                                              FontVariation(
                                                                "wght",
                                                                1000,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                SizedBox(
                                                  height: 24,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        nudge.interests.length,
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(), // disable nested scroll

                                                    itemBuilder: (context, index) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 2,
                                                            ),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(6),
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    16,
                                                                  ),
                                                                ),
                                                            border: Border.all(
                                                              color: Color(
                                                                0xFFF6DDE1,
                                                              ),
                                                              width: 1.5,
                                                            ),
                                                            color: Color(
                                                              0x54F6DDE1,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                "${nudge.interests[index].iconAsset}",
                                                                scale: 4,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "${nudge.interests[index].name}",
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      "Rethink Sans",
                                                                  fontSize: 6,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(child: Container()),
                                            Column(
                                              children: [
                                                Image.asset(
                                                  "assets/nudges/tick.png",
                                                  scale: 4,
                                                ),
                                                SizedBox(height: 30),
                                                Image.asset(
                                                  "assets/nudges/cross.png",
                                                  scale: 4,
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 7),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
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
