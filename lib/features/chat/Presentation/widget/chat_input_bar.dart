import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';
import 'chat_send_button.dart';
import 'chat_text_form_field.dart';

class ChatInputBar extends StatefulWidget {
  final ValueChanged<String>? onSendMessage;

  const ChatInputBar({
    super.key,
    this.onSendMessage,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSendMessage?.call(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: 12.h,
          top: 6.h,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 6.h,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(
              color: isDark
                  ? AppColors.cardBorderDark
                  : AppColors.cardBorderLight,
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? AppColors.chatInputGlowDark
                    : AppColors.chatInputGlowLight,
                blurRadius: 20.r,
                spreadRadius: 2.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ChatTextFormField(
                  controller: _controller,
                  onSubmitted: (_) => _handleSend(),
                ),
              ),
              SizedBox(width: 8.w),
              ChatSendButton(
                onPressed: _handleSend,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

