import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconPath,
    this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final String iconPath;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = BorderRadius.circular(16.r);

    return Container(
      width: double.infinity,
      height: 52.h,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: radius,
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.socialBorder,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 10.r,
                  offset: Offset(0, 3.h),
                ),
              ],
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: isLoading ? null : (onPressed ?? () {}),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDark ? AppColors.white : AppColors.brandBlue,
                    ),
                  ),
                )
              else
                SvgPicture.asset(
                  iconPath,
                  width: 24.w,
                  height: 24.h,
                ),
              SizedBox(width: 12.w),
              Text(
                text,
                style: AppFontStyles.font15MediumText(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

