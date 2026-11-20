import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/navigation.dart';
import '../../../../core/utils/colors.dart';

class ChatBackButton extends StatelessWidget {
  const ChatBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: () => pop(context),
        borderRadius: BorderRadius.circular(12.r),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18.r,
          color: isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
        ),
      ),
    );
  }
}
