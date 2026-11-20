import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/colors.dart';

class ChatActionButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;

  const ChatActionButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(
            isDark ? AppColors.textPrimaryDark : AppColors.textSubtitleLight,
            BlendMode.srcIn,
          ),
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}
