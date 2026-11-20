import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:link_savw_chat/core/constatnts/icons.dart';

import '../../../../core/utils/colors.dart';

class ChatPinIcon extends StatelessWidget {
  const ChatPinIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 22.h,
      child: Center(
        child: SvgPicture.asset(
          AppIcons.pin,
          colorFilter: ColorFilter.mode(
            isDark ? AppColors.textSecondaryDark : AppColors.textSubtitleLight,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
