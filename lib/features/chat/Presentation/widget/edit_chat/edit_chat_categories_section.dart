import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/features/home/Data/models/category_model.dart';

import 'edit_chat_categories_bar.dart';

class EditChatCategoriesSection extends StatelessWidget {
  final List<CategoryModel> categories;
  final String selectedCategoryId;
  final ValueChanged<String> onCategorySelected;
  final VoidCallback? onAddCategory;

  const EditChatCategoriesSection({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    this.onAddCategory,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSubtitleLight,
            ),
          ),
          SizedBox(height: 10.h),
          EditChatCategoriesBar(
            categories: categories,
            selectedCategoryId: selectedCategoryId,
            onCategorySelected: onCategorySelected,
            onAddCategory: onAddCategory,
          ),
        ],
      ),
    );
  }
}

