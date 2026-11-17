import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_savw_chat/core/constatnts/icons.dart';

import '../../../../core/utils/colors.dart';

class HomeFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const HomeFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.w,
      height: 56.h,
      decoration: BoxDecoration(
        color: AppColors.brandBlue,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.splashGlowDark,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20.r),
          child: Center(
            child: SvgPicture.asset(
              AppIcons.addChat,
              color: AppColors.white,
              width: 30,
              height: 30,
            ),
          ),
        ),
      ),
    );
  }
}
