import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class ChatAvatarInitials extends StatelessWidget {
  final String name;
  final double? fontSize;

  const ChatAvatarInitials({
    super.key,
    required this.name,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name.trim().characters.take(2).toString().toUpperCase();

    return Center(
      child: Text(
        initials,
        style: TextStyle(
          fontSize: fontSize ?? 15.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
    );
  }
}

