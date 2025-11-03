import 'package:buddy_app/constants/event_type_class.dart';

class Nudge {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime dateTime;
  final String category; // e.g. Dinner, Sightseeing
  final String postedBy;
  final int attendeesCount;
  final String status; // requested, accepted, ongoing
  final List<String> tags; // optional interests

  Nudge({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.dateTime,
    required this.category,
    required this.postedBy,
    required this.attendeesCount,
    required this.status,
    this.tags = const [],
  });
}

class Requestor {
  final String pic;
  final String name;
  final int age;
  final List<EventStyle> interests;
  Requestor({
    required this.name,
    required this.age,
    required this.interests,
    required this.pic,
  });
}

class NudgeRequests {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime dateTime;
  final String category; // e.g. Dinner, Sightseeing
  final String postedBy;
  final int attendeesCount;
  final String status; // requested, accepted, ongoing
  final List<String> tags;
  final List<Requestor> requests; // optional interests

  NudgeRequests({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.dateTime,
    required this.category,
    required this.postedBy,
    required this.attendeesCount,
    required this.status,
    this.tags = const [],
    required this.requests,
  });
}
