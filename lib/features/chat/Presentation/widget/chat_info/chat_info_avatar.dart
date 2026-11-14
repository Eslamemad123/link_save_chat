import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

import 'chat_info_avatar_placeholder.dart';

class ChatInfoAvatar extends StatelessWidget {
  final String? image;
  final String name;
  final VoidCallback? onBadgeTap;

  const ChatInfoAvatar({
    super.key,
    this.image,
    required this.name,
    this.onBadgeTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final img = image?.trim();

    Widget content = const ChatInfoAvatarPlaceholder();
    if (img != null && img.isNotEmpty) {
      final isOnline = img.startsWith('http://') || img.startsWith('https://');

      if (isOnline) {
        content = ClipOval(
          child: CachedNetworkImage(
            imageUrl: img,
            width: 96.w,
            height: 96.h,
            fit: BoxFit.cover,
            placeholder: (context, url) => const ChatInfoAvatarPlaceholder(),
            errorWidget: (context, url, error) =>
                const ChatInfoAvatarPlaceholder(),
          ),
        );
      } else if (!kIsWeb) {
        final file = File(img);
        if (file.existsSync()) {
          content = ClipOval(
            child: Image.file(
              file,
              width: 96.w,
              height: 96.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const ChatInfoAvatarPlaceholder(),
            ),
          );
        }
      }
    }

    return Center(
      child: SizedBox(
        width: 104.w,
        height: 104.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 96.w,
              height: 96.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark
                      ? AppColors.cardBorderDark
                      : AppColors.cardBorderLight,
                  width: 2.w,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
