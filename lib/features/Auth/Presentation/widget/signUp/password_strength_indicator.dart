import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

export 'package:password_strength_checker/password_strength_checker.dart'
    show PasswordStrength;

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({
    super.key,
    required this.strength,
  });

  final ValueNotifier<PasswordStrength?> strength;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ValueListenableBuilder<PasswordStrength?>(
      valueListenable: strength,
      builder: (context, currentStrength, _) {
        if (currentStrength == null) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: currentStrength.statusColor,
            ),
            child: PasswordStrengthChecker<PasswordStrength>(
              strength: strength,
              configuration: PasswordStrengthCheckerConfiguration(
                height: 12.h,
                borderWidth: 1.w,
                hasBorder: true,
                borderColor: isDark
                    ? AppColors.cardBorderDark
                    : AppColors.cardBorderLight,
                inactiveBorderColor: isDark
                    ? AppColors.cardBorderDark
                    : AppColors.cardBorderLight,
                externalBorderRadius: BorderRadius.circular(6.r),
                internalBorderRadius: BorderRadius.circular(4.r),
                animationDuration: const Duration(milliseconds: 300),
                showStatusWidget: true,
                statusMargin: EdgeInsets.only(top: 6.h),
                statusWidgetAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          ),
        );
      },
    );
  }
}
