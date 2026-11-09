import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'create_chat_avatar_badge.dart';

class CreateChatAvatarPicker extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final File? imageFile;
  final VoidCallback? onCameraTap;

  const CreateChatAvatarPicker({
    super.key,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.imageFile,
    this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ??
        (isDark
            ? AppColors.avatarBackgroundDark
            : AppColors.avatarBackgroundLight);
    final ic = iconColor ?? AppColors.brandBlue;

    return Center(
      child: SizedBox(
        width: 104.w,
        height: 104.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: onCameraTap,
              child: Container(
                width: 96.w,
                height: 96.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: bg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: imageFile != null
                    ? Image.file(
                        imageFile!,
                        width: 96.w,
                        height: 96.h,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        icon,
                        size: 42.r,
                        color: ic,
                      ),
              ),
            ),
            Positioned(
              bottom: 4.h,
              left: 4.w,
              child: CreateChatAvatarBadge(
                onTap: onCameraTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
