import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';
import 'create_chat_close_button.dart';

class CreateChatHeader extends StatelessWidget {
  final VoidCallback? onClosePressed;

  const CreateChatHeader({
    super.key,
    this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CreateChatCloseButton(onPressed: onClosePressed),
        Expanded(
          child: Text(
            'Create New Chat 💬',
            textAlign: TextAlign.center,
            style: AppFontStyles.font18BoldTitle(context),
          ),
        ),
        SizedBox(width: 36.w),
      ],
    );
  }
}
