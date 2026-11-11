import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/colors.dart';

class AddCategoryHeader extends StatelessWidget {
  final VoidCallback? onClosePressed;

  const AddCategoryHeader({super.key, this.onClosePressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'New Category',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textTitleLight,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.close_rounded,
            size: 20.r,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSubtitleLight,
          ),
          onPressed: onClosePressed ?? () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
