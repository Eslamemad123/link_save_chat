import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class ChatInfoStatIconBadge extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final Color backgroundColor;

  const ChatInfoStatIconBadge({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 32.w,
      height: 32.h,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          isDark ? AppColors.textPrimaryDark : AppColors.textSubtitleLight,
          BlendMode.srcIn,
        ),
        width: 20,
        height: 20,
      ),
    );
  }
}
