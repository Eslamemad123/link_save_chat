import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'chat_info_back_button.dart';
import 'chat_info_edit_button.dart';

class ChatInfoTopBar extends StatelessWidget {
  final VoidCallback? onEditTap;

  const ChatInfoTopBar({super.key, this.onEditTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ChatInfoBackButton(),
          ChatInfoEditButton(onTap: onEditTap),
        ],
      ),
    );
  }
}

