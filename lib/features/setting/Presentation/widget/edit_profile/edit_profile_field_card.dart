import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/features/setting/Presentation/widget/common/settings_card_container.dart';

class EditProfileFieldCard extends StatelessWidget {
  const EditProfileFieldCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.badge,
    this.onTap,
    this.margin,
  });

  final String label;
  final String value;
  final IconData icon;
  final Widget? badge;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SettingsCardContainer(
      margin: margin ?? EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSubtitleLight,
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textTitleLight,
                    ),
                  ),
                ),
                if (badge != null) ...[
                  badge!,
                  SizedBox(width: 8.w),
                ],
                Icon(
                  icon,
                  color: AppColors.brandBlue,
                  size: 20.r,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

