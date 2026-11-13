import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'edit_chat_back_button.dart';
import 'edit_chat_save_button.dart';
import 'edit_chat_title_text.dart';

class EditChatTopBar extends StatelessWidget {
  final VoidCallback? onSavePressed;
  final bool isLoading;

  const EditChatTopBar({
    super.key,
    required this.onSavePressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const EditChatBackButton(),
          const EditChatTitleText(),
          EditChatSaveButton(
            onPressed: onSavePressed,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}

