import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';
import '../../Data/models/chat_model.dart';
import 'chat_card_item.dart';

class ChatListView extends StatelessWidget {
  final List<ChatModel> chats;
  final Future<void> Function() onRefresh;
  final ValueChanged<ChatModel>? onChatTap;

  const ChatListView({
    super.key,
    required this.chats,
    required this.onRefresh,
    this.onChatTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (chats.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.folder_open_rounded,
                size: 64.r,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSubtitleLight,
              ),
              SizedBox(height: 16.h),
              Text(
                'No Links or Tasks Found',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textTitleLight,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Tap the + button to create a new category',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSubtitleLight,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.brandBlue,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 12.h,
          bottom: 90.h,
        ),
        itemCount: chats.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ChatCardItem(
            chat: chat,
            onTap: onChatTap != null ? () => onChatTap!(chat) : null,
          );
        },
      ),
    );
  }
}
