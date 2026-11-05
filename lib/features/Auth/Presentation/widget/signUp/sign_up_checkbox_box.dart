import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class SignUpCheckboxBox extends StatelessWidget {
  const SignUpCheckboxBox({
    super.key,
    required this.isChecked,
  });

  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 22.w,
      height: 22.h,
      decoration: BoxDecoration(
        color: isChecked ? AppColors.brandBlue : AppColors.transparent,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: isChecked
              ? AppColors.brandBlue
              : (isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight),
          width: 1.5,
        ),
      ),
      child: isChecked
          ? Icon(
              Icons.check,
              size: 16.r,
              color: AppColors.white,
            )
          : null,
    );
  }
}

