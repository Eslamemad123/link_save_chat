import 'package:flutter/material.dart';

class CategoryItemData {
  final String id;
  final String label;
  final String emoji;
  final IconData icon;
  final Color lightBgColor;
  final Color darkBgColor;
  final Color accentColor;

  const CategoryItemData({
    required this.id,
    required this.label,
    required this.emoji,
    required this.icon,
    required this.lightBgColor,
    required this.darkBgColor,
    required this.accentColor,
  });
}

