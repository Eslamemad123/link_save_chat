import 'package:flutter/material.dart';
import '../../../../../core/utils/colors.dart';

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

  static const List<CategoryItemData> defaultCategories = [
    CategoryItemData(
      id: 'programming',
      label: 'Programming',
      emoji: '💻',
      icon: Icons.integration_instructions_rounded,
      lightBgColor: AppColors.filterChipActiveLight,
      darkBgColor: AppColors.filterChipActiveDark,
      accentColor: AppColors.brandBlue,
    ),
    CategoryItemData(
      id: 'videos',
      label: 'Videos',
      emoji: '🎬',
      icon: Icons.play_circle_outline_rounded,
      lightBgColor: AppColors.redContainerLight,
      darkBgColor: AppColors.redContainerDark,
      accentColor: AppColors.categoryVideoText,
    ),
    CategoryItemData(
      id: 'articles',
      label: 'Articles',
      emoji: '📚',
      icon: Icons.menu_book_rounded,
      lightBgColor: AppColors.greenContainerLight,
      darkBgColor: AppColors.greenContainerDark,
      accentColor: AppColors.categoryArticleText,
    ),
    CategoryItemData(
      id: 'work',
      label: 'Work',
      emoji: '💼',
      icon: Icons.work_outline_rounded,
      lightBgColor: AppColors.amberContainerLight,
      darkBgColor: AppColors.amberContainerDark,
      accentColor: AppColors.avatarAmber,
    ),
    CategoryItemData(
      id: 'ideas',
      label: 'Ideas',
      emoji: '💡',
      icon: Icons.lightbulb_outline_rounded,
      lightBgColor: AppColors.purpleContainerLight,
      darkBgColor: AppColors.purpleContainerDark,
      accentColor: AppColors.purplePrimary,
    ),
    CategoryItemData(
      id: 'goals',
      label: 'Goals',
      emoji: '🎯',
      icon: Icons.track_changes_rounded,
      lightBgColor: AppColors.tealContainerLight,
      darkBgColor: AppColors.tealContainerDark,
      accentColor: AppColors.tealPrimary,
    ),
  ];
}
