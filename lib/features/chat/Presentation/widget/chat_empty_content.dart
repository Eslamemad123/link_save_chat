import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'chat_blur_glow_container.dart';
import 'chat_empty_subtitle_text.dart';
import 'chat_empty_title_text.dart';
import 'chat_lottie_animation.dart';

class ChatEmptyContent extends StatelessWidget {
  const ChatEmptyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            const ChatBlurGlowContainer(
              child: ChatLottieAnimation(),
            ),
            SizedBox(height: 28.h),
            const ChatEmptyTitleText(),
            SizedBox(height: 12.h),
            const ChatEmptySubtitleText(),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

