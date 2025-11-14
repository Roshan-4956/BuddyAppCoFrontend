import 'package:buddy_app/old/Widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/event_ticket_list.dart';

class EventDetailPage extends ConsumerStatefulWidget {
  final EventTicket event;
  const EventDetailPage({super.key, required this.event});

  @override
  ConsumerState<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends ConsumerState<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarr(
        Name: "Sakshi",
        Location: "Delhi",
      ), // your reusable appbar

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  event.pic,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 13,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xABF6DDE1),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Color(0xFFF6DDE1),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(event.type.iconAsset, scale: 4),
                              const SizedBox(width: 6),
                              Text(
                                event.type.name,
                                style: const TextStyle(
                                  fontFamily: "Rethink Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        // Attendees Avatars
                        // Stack(
                        //   children: [
                        //     Row(
                        //       children: event.attendeesAvatars.take(3).map((a) {
                        //         final index =
                        //         event.attendeesAvatars.indexOf(a);
                        //         return Padding(
                        //           padding: EdgeInsets.only(left: index * 20),
                        //           child: CircleAvatar(
                        //             radius: 16,
                        //             backgroundImage: AssetImage(a),
                        //           ),
                        //         );
                        //       }).toList(),
                        //     ),
                        //     Positioned(
                        //       left: 70,
                        //       child: Text(
                        //         "${event.attendeesCount}+",
                        //         style: const TextStyle(
                        //           fontFamily: "Rethink Sans",
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w600,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Title
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontFamily: "Rethink Sans",
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Location & Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("assets/events/locPin.png", scale: 4),
                        const SizedBox(width: 4),
                        Text(
                          event.venue,
                          style: const TextStyle(
                            fontFamily: "Rethink Sans",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8793A1),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 12),
                        Image.asset("assets/events/calPin.png", scale: 4),
                        const SizedBox(width: 4),
                        Text(
                          event.date,
                          style: const TextStyle(
                            fontFamily: "Rethink Sans",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8793A1),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // About Event
                    const Text(
                      "About Event",
                      style: TextStyle(
                        fontFamily: "Rethink Sans",
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      event.about,
                      style: const TextStyle(
                        fontFamily: "Rethink Sans",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8793A1),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // What's New
                    const Text(
                      "What’s New",
                      style: TextStyle(
                        fontFamily: "Rethink Sans",
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Column(
                      children: event.whatsNew.map((point) {
                        return Row(
                          children: [
                            Image.asset("assets/community/tick.png", scale: 4),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                point,
                                style: const TextStyle(
                                  fontFamily: "Rethink Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Seats Remaining
                    Container(
                      height: 70,
                      padding: const EdgeInsets.fromLTRB(12, 9, 12, 0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF64BDFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${event.bookedSeats}/${event.totalSeats}",
                                style: const TextStyle(
                                  fontFamily: "Rethink Sans",
                                  fontSize: 24,
                                  fontVariations: [FontVariation('wght', 1000)],
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "No of seats remaining",
                                style: TextStyle(
                                  fontFamily: "Rethink Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                            "assets/community/blueGraphic.png",
                            scale: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Price Bar
      bottomNavigationBar: Container(
        height: 99,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Color(0xFFF3F4F5),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Price",
                  style: TextStyle(
                    fontFamily: "Rethink Sans",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8793A1),
                  ),
                ),
                Text(
                  "₹ ${event.price}",
                  style: const TextStyle(
                    fontFamily: "Rethink Sans",
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF6DDE1),
                padding: const EdgeInsets.symmetric(
                  horizontal: 44,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                context.push(
                  '/buyEvent',
                  extra: event, // ⬅ pass EventTicket here
                );
              },
              child: const Text(
                "Join Event",
                style: TextStyle(
                  fontFamily: "Rethink Sans",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
