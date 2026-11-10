import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constatnts/images.dart';
import '../../../../core/utils/colors.dart';

class ChatAvatarIcon extends StatelessWidget {
  final String? image;
  final String name;

  const ChatAvatarIcon({
    super.key,
    this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final img = image?.trim();

    if (img != null && img.isNotEmpty) {
      final isOnline = img.startsWith('http://') || img.startsWith('https://');

      return CircleAvatar(
        radius: 20.r,
        backgroundColor: isDark
            ? AppColors.chatHeaderIconContainerDark
            : AppColors.chatHeaderIconContainerLight,
        backgroundImage: isOnline
            ? NetworkImage(img)
            : FileImage(File(img)) as ImageProvider,
        onBackgroundImageError: (_, _) {},
      );
    }

    return Container(
      width: 42.w,
      height: 42.h,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.chatHeaderIconContainerDark
            : AppColors.chatHeaderIconContainerLight,
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark
              ? AppColors.cardBorderDark
              : AppColors.cardBorderLight,
          width: 1.w,
        ),
      ),
      alignment: Alignment.center,
      child: Image.asset(
        AppAssets.folderIcon,
        width: 24.w,
        height: 24.h,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.folder_rounded,
            size: 22.r,
            color: AppColors.brandBlue,
          );
        },
      ),
    );
  }
}

