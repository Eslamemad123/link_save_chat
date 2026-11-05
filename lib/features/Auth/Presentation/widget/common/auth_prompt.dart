import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class AuthPrompt extends StatelessWidget {
  const AuthPrompt({
    super.key,
    required this.promptText,
    required this.actionText,
    this.onActionPressed,
  });

  final String promptText;
  final String actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: AppFontStyles.font14RegularSubtitle(context),
        ),
        SizedBox(width: 6.w),
        GestureDetector(
          onTap: onActionPressed,
          behavior: HitTestBehavior.opaque,
          child: Text(
            actionText,
            style: AppFontStyles.font14BoldPrimary(context),
          ),
        ),
      ],
    );
  }
}

