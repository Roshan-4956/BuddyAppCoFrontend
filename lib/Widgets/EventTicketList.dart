import 'package:flutter/material.dart';

import '../constants/event_ticket_list.dart';

class TicketCard extends StatelessWidget {
  final EventTicket ticket;
  final bool isExpired;

  const TicketCard({Key? key, required this.ticket, this.isExpired = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isExpired ? 1 : 1.0, // faded if expired
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background ticket image
          isExpired ? Image.asset("assets/events/greyTicket.png", fit: BoxFit.fill):Image.asset(ticket.type.ticketAsset, fit: BoxFit.fill),

          // Details overlay
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 20, 0, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                // Title + Icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      ticket.title,
                      style: TextStyle(
                        fontFamily: "Bebas Neue",
                          fontSize: 16, fontWeight: FontWeight.bold, color: isExpired ?Color(0x991E1E1E):Color(0xFF1E1E1E)),
                    ),
                    const SizedBox(width: 5),
                    Image.asset(ticket.type.iconAsset, scale: 4,),
                  ],
                ),
                const SizedBox(height: 0),

                // Venue
                Text(
                  "Venue  ${ticket.venue}",
                  style: TextStyle(fontSize: 8, fontFamily: "Rethink Sans",fontWeight: FontWeight.w900, color: isExpired ?Color(0x991E1E1E):Color(0xFF1E1E1E)),
                ),
                const SizedBox(height: 4),

                // Date
                Text(
                  "Date   ${ticket.date}",
                  style: TextStyle(fontSize: 8, fontFamily: "Rethink Sans", fontWeight: FontWeight.w900, color: isExpired ?Color(0x991E1E1E):Color(0xFF1E1E1E)),
                ),
                const SizedBox(height: 10),

                // Price
                Text(
                  "₹${ticket.price}",
                  style: TextStyle(
                      fontFamily: "Bebas Neue",
                      fontSize: 16, fontWeight: FontWeight.bold, color: isExpired ?Color(0x991E1E1E):Color(0xFF1E1E1E)),

                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TicketsList extends StatelessWidget {
  final List<EventTicket> ongoing;
  final List<EventTicket> expired;

  const TicketsList({Key? key, required this.ongoing, required this.expired})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    widgets.add(Padding(padding: EdgeInsets.only(top: 32)));
    if (ongoing.isNotEmpty) {
      widgets.add(const Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Text("Ongoing Events",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, fontFamily: "Rethink Sans")),
        ),
      ));

      widgets.addAll(ongoing
          .map((e) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: TicketCard(ticket: e),
      ))
          .toList());
    }

    if (expired.isNotEmpty) {
      widgets.add(const Padding(
        padding: EdgeInsets.fromLTRB(12, 34, 12, 16),
        child: Center(
          child: Text("Expired Events",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, fontFamily: "Rethink Sans")),
        ),
      ));

      widgets.addAll(expired
          .map((e) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: TicketCard(ticket: e, isExpired: true),
      ))
          .toList());
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 20),
      children: widgets,
    );
  }
}
