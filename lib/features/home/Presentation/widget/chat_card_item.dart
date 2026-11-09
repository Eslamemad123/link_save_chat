import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/colors.dart';
import '../../Data/models/chat_model.dart';
import 'chat_icon_avatar.dart';
import 'chat_pin_icon.dart';
import 'chat_unread_badge.dart';

class ChatCardItem extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback? onTap;

  const ChatCardItem({super.key, required this.chat, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final messagePreview = chat.lastMessage.isNotEmpty
        ? chat.lastMessage
        : chat.description;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isDark
                  ? AppColors.cardBorderDark
                  : AppColors.cardBorderLight,
              width: 1.w,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              ChatIconAvatar(image: chat.image, name: chat.name),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textTitleLight,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.link_rounded,
                          size: 16.r,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSubtitleLight,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            messagePreview,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSubtitleLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      if (chat.boolIsPin) ...[
                        const ChatPinIcon(),
                        if (chat.nummessage > 0) SizedBox(width: 6.w),
                      ],
                      if (chat.nummessage > 0)
                        ChatUnreadBadge(count: chat.nummessage)
                      else if (!chat.boolIsPin)
                        SizedBox(height: 22.h),
                    ],
                  ),
                  Gap(8),
                  Text(
                    chat.time ?? _formatTimestamp(chat.date),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSubtitleLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatTimestamp(DateTime? dateTime) {
    if (dateTime == null) return '';
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inDays == 0) {
      final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = dateTime.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute $period';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[dateTime.weekday - 1];
    } else {
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[dateTime.month - 1]} ${dateTime.day}';
    }
  }
}
