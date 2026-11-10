import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import '../../../Data/models/category_model.dart';
import 'create_chat_category_chip.dart';

class CreateChatCategoriesBar extends StatelessWidget {
  final List<CategoryModel> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;
  final VoidCallback? onAddCategory;

  const CreateChatCategoriesBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
    this.onAddCategory,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + (onAddCategory != null ? 1 : 0),
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          if (onAddCategory != null && index == categories.length) {
            return Material(
              color: AppColors.transparent,
              child: InkWell(
                onTap: onAddCategory,
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceDark
                        : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isDark
                          ? AppColors.cardBorderDark
                          : AppColors.cardBorderLight,
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        size: 16.r,
                        color: AppColors.brandBlue,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.brandBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final category = categories[index];
          return CreateChatCategoryChip(
            category: category,
            isSelected: index == selectedIndex,
            onTap: () => onCategorySelected(index),
          );
        },
      ),
    );
  }
}
