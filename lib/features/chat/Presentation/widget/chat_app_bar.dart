import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/chat_icon_avatar.dart';
import '../../../../core/utils/colors.dart';
import 'chat_back_button.dart';
import 'chat_header_info.dart';
import 'chat_info_button.dart';
import 'chat_search_button.dart';

class ChatAppBar extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback? onSearchTap;
  final VoidCallback? onInfoTap;

  const ChatAppBar({
    super.key,
    required this.chat,
    this.onSearchTap,
    this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.surfaceDark : AppColors.surfaceLight)
            .withValues(alpha: 0.85),
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? AppColors.cardBorderDark
                : AppColors.cardBorderLight,
            width: 1.w,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            const ChatBackButton(),
            SizedBox(width: 12.w),
            ChatIconAvatar(
              image: chat.image,
              name: chat.name,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ChatHeaderInfo(
                name: chat.name,
                subtitle: chat.description.isNotEmpty
                    ? chat.description
                    : 'New Chat',
              ),
            ),
            ChatSearchButton(
              onTap: onSearchTap,
            ),
            SizedBox(width: 8.w),
            ChatInfoButton(
              onTap: onInfoTap,
            ),
          ],
        ),
      ),
    );
  }
}
