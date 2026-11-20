import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/features/chat/Presentation/widget/chat_info/chat_info_back_button.dart';

import 'edit_chat_title_text.dart';

class EditChatTopBar extends StatelessWidget {
  const EditChatTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ChatInfoBackButton(),
          const EditChatTitleText(),
          SizedBox(width: 44.w),
        ],
      ),
    );
  }
}

