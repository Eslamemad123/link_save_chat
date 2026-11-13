import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

import 'edit_chat_avatar_placeholder.dart';
import 'edit_chat_camera_badge.dart';

class EditChatAvatarPreview extends StatelessWidget {
  final Uint8List? imageBytes;
  final File? imageFile;
  final String? imageUrl;
  final VoidCallback? onCameraTap;

  const EditChatAvatarPreview({
    super.key,
    this.imageBytes,
    this.imageFile,
    this.imageUrl,
    this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasRemote = imageUrl != null && imageUrl!.trim().isNotEmpty;

    Widget content = const EditChatAvatarPlaceholder();

    if (imageBytes != null) {
      content = Image.memory(
        imageBytes!,
        width: 104.w,
        height: 104.h,
        fit: BoxFit.cover,
      );
    } else if (imageFile != null && !kIsWeb) {
      content = Image.file(
        imageFile!,
        width: 104.w,
        height: 104.h,
        fit: BoxFit.cover,
      );
    } else if (hasRemote) {
      content = Image.network(
        imageUrl!,
        width: 104.w,
        height: 104.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const EditChatAvatarPlaceholder(),
      );
    }

    return Center(
      child: SizedBox(
        width: 114.w,
        height: 114.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: onCameraTap,
              child: Container(
                width: 104.w,
                height: 104.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? AppColors.avatarBackgroundDark
                      : AppColors.avatarBackgroundLight,
                  border: Border.all(
                    color: isDark
                        ? AppColors.cardBorderDark
                        : AppColors.cardBorderLight,
                    width: 2.w,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: content,
              ),
            ),
            Positioned(
              bottom: 4.h,
              left: 4.w,
              child: EditChatCameraBadge(onTap: onCameraTap),
            ),
          ],
        ),
      ),
    );
  }
}
