import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'chat_info_avatar.dart';
import 'chat_info_date_badge.dart';
import 'chat_info_title_text.dart';

class ChatInfoProfileSection extends StatelessWidget {
  final String? image;
  final String name;
  final DateTime? createdAt;
  final VoidCallback? onAvatarBadgeTap;

  const ChatInfoProfileSection({
    super.key,
    this.image,
    required this.name,
    this.createdAt,
    this.onAvatarBadgeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          ChatInfoAvatar(
            image: image,
            name: name,
            onBadgeTap: onAvatarBadgeTap,
          ),
          SizedBox(height: 14.h),
          ChatInfoTitleText(title: name),
          SizedBox(height: 8.h),
          ChatInfoDateBadge(date: createdAt),
        ],
      ),
    );
  }
}

