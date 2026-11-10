import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';

class ChatSendButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isEnabled;

  const ChatSendButton({
    super.key,
    this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.h,
      decoration: BoxDecoration(
        color: AppColors.brandBlue,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: AppColors.chatSendButtonGlow,
            blurRadius: 14,
            spreadRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          customBorder: const CircleBorder(),
          child: Center(
            child: Icon(
              Icons.arrow_upward_rounded,
              color: AppColors.white,
              size: 22.r,
            ),
          ),
        ),
      ),
    );
  }
}

