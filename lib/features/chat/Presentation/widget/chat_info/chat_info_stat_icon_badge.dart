import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatInfoStatIconBadge extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const ChatInfoStatIconBadge({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.w,
      height: 32.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 16.r, color: iconColor),
    );
  }
}

