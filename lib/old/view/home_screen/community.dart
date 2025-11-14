import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../constants/event_ticket_list.dart';
import '../../constants/interest_tiles_data.dart';

class CommunityPage extends ConsumerStatefulWidget {
  final List<EventTicket> popularEvents;
  final List<EventTicket> allEvents;

  const CommunityPage({
    super.key,
    required this.allEvents,
    required this.popularEvents,
  });

  @override
  ConsumerState<CommunityPage> createState() => _communityState();
}

class _communityState extends ConsumerState<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () => context.push('/addEvent'),
        child: Container(
          height: 66,
          width: 66,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF6DDE1),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/homepage/eventNav.png",
                  scale: 4,
                  color: Color(0xFF1E1E1E),
                ),
                SizedBox(height: 6),
                Text(
                  "Add",
                  style: TextStyle(
                    fontFamily: "Rethink Sans",
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E1E1E),
                    height: 1.07,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Join Communities
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: const Text(
                "Join Communities",
                style: TextStyle(
                  fontFamily: "Rethink Sans",
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
            SizedBox(
              height: 108,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: interestTiles.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final tile = interestTiles[index];
                  return Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Color(0x4DF6DDE1),
                          border: Border.all(
                            color: Color(0xFFF6DDE1),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Image.asset(tile.iconPath, scale: 2),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        tile.title,
                        style: const TextStyle(
                          fontFamily: "Rethink Sans",
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Popular Events
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: const Text(
                "Popular Events",
                style: TextStyle(
                  fontFamily: "Rethink Sans",
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
            SizedBox(
              height: 252,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.popularEvents.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final event = widget.popularEvents[index];
                  return GestureDetector(
                    onTap: () => context.push(
                      '/eventDetails',
                      extra: event, // ⬅ pass EventTicket here
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: 232,
                        width: 242,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Event Image + top right icon
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(11),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                    child: Image.asset(
                                      event.pic,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 18,
                                  right: 18,
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                      event.type.iconAsset,
                                      scale: 4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    event.title,
                                    style: const TextStyle(
                                      fontFamily: "Rethink Sans",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "₹ ${event.price}",
                                    style: const TextStyle(
                                      fontFamily: "Rethink Sans",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/community/yellowCalPin.png",
                                    scale: 4,
                                  ),
                                  Text(
                                    "${event.date} ${event.time}PM",
                                    style: const TextStyle(
                                      fontFamily: "Rethink Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF8793A1),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Expanded(child: Container()),
                                  Image.asset(
                                    "assets/events/seatsPin.png",
                                    scale: 4,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 1,
                                    ),
                                  ),
                                  Text(
                                    "${event.bookedSeats}/${event.totalSeats}",
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Rethink Sans",
                                      color: Color(0xFF8793A1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/community/yellowLocPin.png",
                                    scale: 4,
                                  ),
                                  Text(
                                    "Mumbai",
                                    style: const TextStyle(
                                      fontFamily: "Rethink Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF8793A1),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Expanded(child: Container()),

                                  Text(
                                    "Created by a buddy",
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Rethink Sans",
                                      color: Color(0xFF1E1E1E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // All Events
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              child: const Text(
                "All Events",
                style: TextStyle(
                  fontFamily: "Rethink Sans",
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),
            Column(
              children: widget.allEvents.map((details) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          details.pic,
                          height: 72,
                          width: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Info Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title + Icon
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  details.title,
                                  style: const TextStyle(
                                    fontFamily: "Rethink Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 6),
                                Image.asset(details.type.iconAsset, scale: 4),
                              ],
                            ),
                            const SizedBox(height: 6),

                            Row(
                              children: [
                                Image.asset(
                                  "assets/events/locPin.png",
                                  scale: 4,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    details.venue,
                                    style: const TextStyle(
                                      fontFamily: "Rethink Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF8793A1),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            Row(
                              children: [
                                Image.asset(
                                  "assets/events/calPin.png",
                                  scale: 4,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  details.date,
                                  style: const TextStyle(
                                    fontFamily: "Rethink Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF8793A1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            Row(
                              children: [
                                Image.asset(
                                  "assets/events/timePin.png",
                                  scale: 4,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${details.time} PM",
                                  style: const TextStyle(
                                    fontFamily: "Rethink Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF8793A1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Price + Seats
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹ ${details.price}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Rethink Sans",
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Created by a buddy",
                            style: TextStyle(
                              fontFamily: "Rethink Sans",
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E1E1E),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
