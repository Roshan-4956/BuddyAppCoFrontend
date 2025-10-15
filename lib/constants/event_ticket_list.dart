import 'package:buddy_app/constants/event_type_class.dart';

class EventTicket {
  final String title;
  final String time;
  final String pic;
  final String venue;
  final String date;
  final List<String> whatsNew;
  final int price;
  final int bookedSeats;
  final int totalSeats;
  final String about;

  final EventStyle type; // background ticket design

  EventTicket({
    required this.title,
    required this.bookedSeats,
    required this.totalSeats,
    required this.pic,
    required this.time,
    required this.venue,
    required this.date,
    required this.price,
    required this.type,
    required this.whatsNew,
    required this.about

  });
}