import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';
import '../../../Data/models/category_model.dart';

class CreateChatCategoryChip extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  const CreateChatCategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isSelected
        ? (isDark
            ? AppColors.filterChipActiveDark
            : AppColors.filterChipActiveLight)
        : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);

    final borderColor = isSelected
        ? AppColors.brandBlue
        : (isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight);

    final textColor = isSelected
        ? AppColors.brandBlue
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSubtitleLight);

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 8.h,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: borderColor,
              width: isSelected ? 1.5.w : 1.w,
            ),
          ),
          child: Text(
            category.name,
            style: AppFontStyles.font13MediumChip(
              context,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
