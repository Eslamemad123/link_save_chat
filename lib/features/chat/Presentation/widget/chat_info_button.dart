import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class ChatInfoButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ChatInfoButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Icon(
          Icons.info_outline_rounded,
          size: 23.r,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
        ),
      ),
    );
  }
}
