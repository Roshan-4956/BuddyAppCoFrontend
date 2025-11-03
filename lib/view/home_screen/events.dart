import 'package:buddy_app/Widgets/EventTicketList.dart';
import 'package:buddy_app/constants/event_ticket_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../Widgets/MyEventList.dart';
import '../../Widgets/eventPageSelector.dart';

final eventsTabProvider = StateProvider<int>((ref) => 0);

class events extends ConsumerStatefulWidget {
  final List<EventTicket> presentEvents;
  final List<EventTicket> pastEvents;
  final List<EventTicket> myPresentEvents;
  final List<EventTicket> myPastEvents;

  const events({
    super.key,
    required this.presentEvents,
    required this.pastEvents,
    required this.myPresentEvents,
    required this.myPastEvents,
  });

  @override
  ConsumerState<events> createState() => _eventsState();
}

class _eventsState extends ConsumerState<events> {
  final PageController _pageController = PageController(
    viewportFraction: 0.9,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(eventsTabProvider);
    return Column(
      children: [
        SizedBox(height: 36),
        EventsSelector(),

        Expanded(
          child: IndexedStack(
            index: selectedIndex,
            children: [
              TicketsList(
                ongoing: widget.presentEvents,
                expired: widget.pastEvents,
              ),
              EventCardsList(
                currentEvents: widget.myPresentEvents,
                pastEvents: widget.myPastEvents,
              ),
            ],
          ),
        ),
        // Expanded(
        //   child: TicketsList(
        //     ongoing: widget.presentEvents,
        //     expired: widget.pastEvents,
        //   ),
        // ),
      ],
    );
  }
}
