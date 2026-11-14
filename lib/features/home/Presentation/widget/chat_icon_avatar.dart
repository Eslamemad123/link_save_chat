import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';
import 'chat_avatar_initials.dart';

class ChatIconAvatar extends StatelessWidget {
  final String? image;
  final String name;

  const ChatIconAvatar({super.key, this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    final img = image?.trim();
    final bgColor = _colorFromName(name);

    if (img != null && img.isNotEmpty) {
      final isOnline = img.startsWith('http://') || img.startsWith('https://');

      if (isOnline) {
        return CircleAvatar(
          radius: 24.r,
          backgroundColor: bgColor,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: img,
              width: 48.r,
              height: 48.r,
              fit: BoxFit.cover,
              placeholder: (context, url) => ChatAvatarInitials(name: name),
              errorWidget: (context, url, error) =>
                  ChatAvatarInitials(name: name),
            ),
          ),
        );
      } else if (!kIsWeb) {
        final file = File(img);
        if (file.existsSync()) {
          return CircleAvatar(
            radius: 24.r,
            backgroundColor: bgColor,
            child: ClipOval(
              child: Image.file(
                file,
                width: 48.r,
                height: 48.r,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    ChatAvatarInitials(name: name),
              ),
            ),
          );
        }
      }
    }

    return CircleAvatar(
      radius: 24.r,
      backgroundColor: bgColor,
      child: ChatAvatarInitials(name: name),
    );
  }

  Color _colorFromName(String name) {
    final hash = name.trim().codeUnits.fold<int>(0, (a, b) => a + b);
    return AppColors.avatarColors[hash % AppColors.avatarColors.length];
  }
}
