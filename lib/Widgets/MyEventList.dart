import 'package:buddy_app/constants/event_ticket_list.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final EventTicket details;
  final bool isPast;

  const EventCard({super.key, required this.details, this.isPast = false});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isPast ? 0.5 : 1.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                    mainAxisAlignment: MainAxisAlignment.start,
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

                  // Venue
                  Row(
                    children: [
                      Image.asset("assets/events/locPin.png", scale: 4),
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

                  // Date
                  Row(
                    children: [
                      Image.asset("assets/events/calPin.png", scale: 4),
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

                  // Time
                  Row(
                    children: [
                      Image.asset("assets/events/timePin.png", scale: 4),
                      const SizedBox(width: 4),
                      Text(
                        details.time,
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                Row(
                  children: [
                    Image.asset("assets/events/seatsPin.png", scale: 4),
                    const SizedBox(width: 4),
                    Text(
                      "${details.bookedSeats}/${details.totalSeats}",
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Rethink Sans",
                        color: Color(0xFF8793A1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EventCardsList extends StatelessWidget {
  final List<EventTicket> currentEvents;
  final List<EventTicket> pastEvents;

  const EventCardsList({
    super.key,
    required this.currentEvents,
    required this.pastEvents,
  });

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    if (currentEvents.isNotEmpty) {
      widgets.add(
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Current Events",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              fontFamily: "Rethink Sans",
            ),
          ),
        ),
      );

      widgets.addAll(currentEvents.map((e) => EventCard(details: e)).toList());
    }

    if (pastEvents.isNotEmpty) {
      widgets.add(
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Past Events",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              fontFamily: "Rethink Sans",
            ),
          ),
        ),
      );

      widgets.addAll(
        pastEvents.map((e) => EventCard(details: e, isPast: true)).toList(),
      );
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 20),
      children: widgets,
    );
  }
}
