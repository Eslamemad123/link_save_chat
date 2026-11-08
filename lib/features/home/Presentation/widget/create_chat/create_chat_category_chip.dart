import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';
import 'category_item_data.dart';

class CreateChatCategoryChip extends StatelessWidget {
  final CategoryItemData category;
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
        : (isDark ? category.darkBgColor : category.lightBgColor);

    final borderColor = isSelected
        ? AppColors.brandBlue
        : (isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight);

    final textColor = isSelected ? AppColors.brandBlue : category.accentColor;

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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category.emoji,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                category.label,
                style: AppFontStyles.font13MediumChip(
                  context,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
