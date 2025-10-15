import 'package:buddy_app/Widgets/nudgePageSelector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

import '../../Widgets/myNudges.dart';
import '../../Widgets/nudgeCard.dart';
import '../../Widgets/sentNudges.dart';
import '../../constants/nudge_model.dart';

final nudgeTabProvider = StateProvider<int>((ref) => 0);

class NudgePage extends ConsumerStatefulWidget {
  final List<Nudge> nudges;
  final List<NudgeRequests> ongoingNudges;
  final List<NudgeRequests> Expired;
  final List<Nudge> Sent;
  NudgePage({
    Key? key,
    required this.nudges,
    required this.ongoingNudges,
    required this.Expired,
    required this.Sent,
  }) : super(key: key);

  @override
  ConsumerState<NudgePage> createState() => _NudgePageState();
}

class _NudgePageState extends ConsumerState<NudgePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(nudgeTabProvider);
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          SizedBox(height: 29),
          Container(
            width: (MediaQuery.of(context).size.width) - 30,
            height: 63,
            decoration: BoxDecoration(
              color: Color(0xFFF6DDE1),
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create a Nudge",
                          style: TextStyle(
                            fontFamily: "Rethink Sans",
                            fontSize: 16,
                            height: 1.07,
                            fontVariations: [FontVariation("wght", 1000)],
                            color: Color(0xff1e1e1e),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Tired of doing things alone? invite others!",
                          style: TextStyle(
                            fontFamily: "Rethink Sans",
                            height: 1.07,
                            fontSize: 10,
                            fontVariations: [FontVariation("wght", 900)],
                            color: Color(0xff1e1e1e),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push('/createNudge'),
                  child: Padding(
                    padding: EdgeInsets.only(right: 14),
                    child: SizedBox(
                      width: 88,
                      height: 37,
                      child: Container(
                        child: Center(
                          child: Text(
                            "Try Now",
                            style: TextStyle(
                              fontFamily: "Rethink Sans",
                              fontSize: 16,
                              fontVariations: [
                                FontVariation("wght", 1200)
                              ]
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.white
                        ),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 29),
          NudgeSelector(),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                ExploreNudgesPage(nudges: widget.nudges),
                MyNudgesPage(
                  ongoingNudges: widget.ongoingNudges,
                  expiredNudges: widget.Expired,
                ),
                SentNudgesPage(sentNudges: widget.Sent),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
