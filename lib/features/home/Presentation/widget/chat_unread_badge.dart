import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';

class ChatUnreadBadge extends StatelessWidget {
  final int count;

  const ChatUnreadBadge({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.w,
      height: 22.h,
      decoration: const BoxDecoration(
        color: AppColors.brandBlue,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$count',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
