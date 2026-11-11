import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'chat_empty_title_text.dart';
import 'chat_lottie_animation.dart';

class ChatEmptyContent extends StatelessWidget {
  const ChatEmptyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ChatLottieAnimation(),
          SizedBox(height: 16.h),
          const ChatEmptyTitleText(),
        ],
      ),
    );
  }
}
