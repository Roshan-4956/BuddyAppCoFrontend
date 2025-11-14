import 'package:flutter/material.dart';

class InterestTileData {
  final String iconPath;
  final String title;
  final Color selectedBg;
  final Color selectedBorder;
  InterestTileData({
    required this.iconPath,
    required this.title,
    required this.selectedBg,
    required this.selectedBorder,
  });
}

List<InterestTileData> interestTiles = [
  InterestTileData(
    iconPath: 'assets/interests/sports.png',
    title: 'Sports & Fitness',
    selectedBg: Color(0x1AFFB9FF),
    selectedBorder: Color(0xFFFFB9FF),
  ),
  InterestTileData(
    iconPath: 'assets/interests/food.png',
    title: 'Food & Culinary Arts',
    selectedBg: Color(0x1AF6D307),
    selectedBorder: Color(0xFFF6D307),
  ),
  InterestTileData(
    iconPath: 'assets/interests/health.png',
    title: 'Health & Wellness',
    selectedBg: Color(0x1A98D81E),
    selectedBorder: Color(0xFF98D81E),
  ),
  InterestTileData(
    iconPath: 'assets/interests/gaming.png',
    title: 'Gaming & Esports',
    selectedBg: Color(0x1A8D8DFF),
    selectedBorder: Color(0xFF8D8DFF),
  ),
  InterestTileData(
    iconPath: 'assets/interests/music.png',
    title: 'Music',
    selectedBg: Color(0x1A64BDFF),
    selectedBorder: Color(0xFF64BDFF),
  ),
  InterestTileData(
    iconPath: 'assets/interests/art.png',
    title: 'Art & Design',
    selectedBg: Color(0x1AF6D307),
    selectedBorder: Color(0xFFF6D307),
  ),
  InterestTileData(
    iconPath: 'assets/interests/books.png',
    title: 'Books & Literature',
    selectedBg: Color(0x1AFFB9FF),
    selectedBorder: Color(0xFFFFB9FF),
  ),
  InterestTileData(
    iconPath: 'assets/interests/tech.png',
    title: 'Technology & Gadgets',
    selectedBg: Color(0x1A8D8DFF),
    selectedBorder: Color(0xFF8D8DFF),
  ),
  InterestTileData(
    iconPath: 'assets/interests/travel.png',
    title: 'Travel & Exploration',
    selectedBg: Color(0x1A98D81E),
    selectedBorder: Color(0xFF98D81E),
  ),
  InterestTileData(
    iconPath: 'assets/interests/adventure.png',
    title: 'Adventure & Outdoor',
    selectedBg: Color(0x1A98D81E),
    selectedBorder: Color(0xFF98D81E),
  ),
  InterestTileData(
    iconPath: 'assets/interests/fashion.png',
    title: 'Fashion & Style',
    selectedBg: Color(0x1AF6D307),
    selectedBorder: Color(0xFFF6D307),
  ),
  InterestTileData(
    iconPath: 'assets/interests/entertainment.png',
    title: 'Pop Culture & Entertainment',
    selectedBg: Color(0x1A64BDFF),
    selectedBorder: Color(0xFF64BDFF),
  ),
];
