import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class ChatPinIcon extends StatelessWidget {
  const ChatPinIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 22.h,
      child: Center(
        child: Transform.rotate(
          angle: 0.785398,
          child: Icon(
            Icons.push_pin,
            size: 16.r,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSubtitleLight,
          ),
        ),
      ),
    );
  }
}
