import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class ChatIconAvatar extends StatelessWidget {
  final String? image;
  final String name;

  const ChatIconAvatar({super.key, this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    final img = image?.trim();

    if (img != null && img.isNotEmpty) {
      final isOnline = img.startsWith('http://') || img.startsWith('https://');

      return CircleAvatar(
        radius: 24.r,
        backgroundColor: _colorFromName(name),
        backgroundImage: isOnline
            ? NetworkImage(img)
            : FileImage(File(img)) as ImageProvider,
        onBackgroundImageError: (_, _) {},
      );
    }

    return CircleAvatar(
      radius: 24.r,
      backgroundColor: _colorFromName(name),
      child: Text(
        name.trim().characters.take(2).toString().toUpperCase(),
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
    );
  }

  Color _colorFromName(String name) {
    final hash = name.trim().codeUnits.fold<int>(0, (a, b) => a + b);
    return AppColors.avatarColors[hash % AppColors.avatarColors.length];
  }
}
