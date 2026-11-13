import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/features/home/Data/models/category_model.dart';

class EditChatCategoryChip extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  const EditChatCategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isSelected
        ? AppColors.brandBlue
        : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);

    final textColor = isSelected
        ? AppColors.white
        : (isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight);

    final borderColor = isSelected
        ? AppColors.brandBlue
        : (isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight);

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: borderColor, width: 1.w),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            category.name,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

