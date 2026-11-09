import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/features/home/Data/models/chat_model.dart';
import 'package:link_savw_chat/features/home/Presentation/widget/chat_card_item.dart';

class ListChats extends StatelessWidget {
  const new({
    super.key,
    required this.onRefresh,
    required this.chats,
    required this.onChatTap,
  });

  final Future<void> Function() onRefresh;
  final List<ChatModel> chats;
  final ValueChanged<ChatModel>? onChatTap;

  @override
  Widget build(BuildContext context) {
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
