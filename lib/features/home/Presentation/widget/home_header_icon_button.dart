import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class HomeHeaderIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const HomeHeaderIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22.r),
        child: Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark
                  ? AppColors.cardBorderDark
                  : AppColors.cardBorderLight,
              width: 1.w,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: icon,
        ),
      ),
    );
  }
}
