import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'category_item_data.dart';
import 'create_chat_bottom_sheet_body.dart';

class CreateChatBottomSheet extends StatefulWidget {
  const CreateChatBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (context) => const CreateChatBottomSheet(),
    );
  }

  @override
  State<CreateChatBottomSheet> createState() => _CreateChatBottomSheetState();
}

class _CreateChatBottomSheetState extends State<CreateChatBottomSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  int _selectedCategoryIndex = 0;

  final List<CategoryItemData> _categories = const [
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

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _onSubmit() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28.r),
          ),
        ),
        child: SafeArea(
          top: false,
          child: CreateChatBottomSheetBody(
            categories: _categories,
            selectedIndex: _selectedCategoryIndex,
            onCategorySelected: _onCategorySelected,
            nameController: _nameController,
            descriptionController: _descriptionController,
            onClosePressed: () => Navigator.of(context).pop(),
            onCameraTap: () {},
            onSubmitPressed: _onSubmit,
          ),
        ),
      ),
    );
  }
}
