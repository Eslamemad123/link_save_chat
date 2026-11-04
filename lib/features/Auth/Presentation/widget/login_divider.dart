import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight;

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            'Or continue with',
            style: AppFontStyles.font14RegularSubtitle(context),
          ),
        ),
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
