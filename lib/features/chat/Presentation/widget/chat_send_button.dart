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
      width: 42.w,
      height: 42.h,
      decoration: const BoxDecoration(
        color: AppColors.brandBlue,
        shape: BoxShape.circle,
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          customBorder: const CircleBorder(),
          child: Center(
            child: Icon(
              Icons.send_rounded,
              color: AppColors.white,
              size: 20.r,
            ),
          ),
        ),
      ),
    );
  }
}
