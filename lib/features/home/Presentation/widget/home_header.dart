import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constatnts/icons.dart';
import '../../../../core/utils/colors.dart';
import 'home_header_icon_button.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onSearchPressed;
  final VoidCallback onSettingsPressed;

  const HomeHeader({
    super.key,
    required this.onSearchPressed,
    required this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Links & Tasks',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HomeHeaderIconButton(
                onTap: onSearchPressed,
                icon: SvgPicture.asset(
                  AppIcons.search,
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
              SizedBox(width: 10.w),
              HomeHeaderIconButton(
                onTap: onSettingsPressed,
                icon: SvgPicture.asset(
                  AppIcons.setting,
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

