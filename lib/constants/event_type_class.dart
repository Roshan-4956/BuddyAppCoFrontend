import 'package:flutter/material.dart';

/// Enum for different event types
enum EventType {
  sports_fitness,
  food_culinary_arts,
  health_wellness,
  gaming_esports,
  music,
  art_design,
  books_literature,
  technology_gadgets,
  travel_exploration,
  adventure_outdoor,
  fashion_style,
  pop_culture_entertainment
}

/// Model class for styling an EventType
class EventStyle {
  final Color primaryColor;
  final String name;

  final String iconAsset;
  final String ticketAsset;

  const EventStyle({
    required this.primaryColor,
    required this.ticketAsset,
    required this.iconAsset,
    required this.name
  });
}

/// Mapping between EventType and its style
class EventStyles {
  static final Map<EventType, EventStyle> styles = {
    EventType.sports_fitness: EventStyle(
      primaryColor: Color(0xFFFFB9FF),
      name: "Sports & Fitness",
      iconAsset: 'assets/interests/sports.png',
      ticketAsset: 'assets/events/pinkTicket.png',
    ),
    EventType.food_culinary_arts: EventStyle(
      name: "Food & Culinary Arts",
      primaryColor: Color(0xFFF6D307),
      ticketAsset: 'assets/events/yellowTicket.png',
      iconAsset: 'assets/interests/food.png',
    ),
    EventType.health_wellness: EventStyle(
      name: "Health & Wellness",
      primaryColor: Color(0xFF98D81E),
      iconAsset: 'assets/interests/health.png',
      ticketAsset: 'assets/events/greenTicket.png',
    ),
    EventType.gaming_esports: EventStyle(
      name: "Gaming & Esports",
      primaryColor: Color(0xFF8D8DFF),
      ticketAsset: 'assets/events/purpleTicket.png',
      iconAsset: 'assets/interests/gaming.png',
    ),
    EventType.music: EventStyle(
      name: "Music",
      primaryColor: Color(0xFF64BDFF),
      ticketAsset: 'assets/events/blueTicket.png',
      iconAsset: 'assets/interests/music.png',
    ),
    EventType.art_design: EventStyle(
      name: "Art & Design",
      primaryColor: Color(0xFFF6D307),
      ticketAsset: 'assets/events/yellowTicket.png',
      iconAsset: 'assets/interests/art.png',
    ),
    EventType.books_literature: EventStyle(
      name: "Books & Literature",
      primaryColor: Color(0xFFFFB9FF),
      ticketAsset: 'assets/events/pinkTicket.png',
      iconAsset: 'assets/interests/books.png',
    ),
    EventType.technology_gadgets: EventStyle(
      name: "Technology & Gadgets",
      primaryColor: Color(0xFF8D8DFF),
      ticketAsset: 'assets/events/purpleTicket.png',
      iconAsset: 'assets/interests/tech.png',
    ),
    EventType.travel_exploration: EventStyle(
      name: "Travel & Exploration",
      primaryColor: Color(0xFF98D81E),
      ticketAsset: 'assets/events/greenTicket.png',
      iconAsset: 'assets/interests/travel.png',
    ),
    EventType.adventure_outdoor: EventStyle(
      name: "Adventure & Outdoor",
      primaryColor: Color(0xFF98D81E),
      ticketAsset: 'assets/events/greenTicket.png',
      iconAsset: 'assets/interests/adventure.png',
    ),
    EventType.fashion_style: EventStyle(
      name: "Fashion & Style",
      primaryColor: Color(0xFFF6D307),
      ticketAsset: 'assets/events/yellowTicket.png',
      iconAsset: 'assets/interests/fashion.png',
    ),
    EventType.pop_culture_entertainment: EventStyle(
      name: "Pop Culture & Entertainment",
      primaryColor: Color(0xFF64BDFF),
      ticketAsset: 'assets/events/blueTicket.png',
      iconAsset: 'assets/interests/entertainment.png',
    ),
  };

  /// Helper to fetch style by type
  static EventStyle of(EventType type) => styles[type]!;
}
