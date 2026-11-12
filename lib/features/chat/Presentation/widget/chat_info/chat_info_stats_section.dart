import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

import 'chat_info_stat_card.dart';

class ChatInfoStatsSection extends StatelessWidget {
  final int overdueCount;
  final int completedCount;
  final int totalCount;

  const ChatInfoStatsSection({
    super.key,
    this.overdueCount = 4,
    this.completedCount = 28,
    this.totalCount = 42,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: ChatInfoStatCard(
              icon: Icons.access_time_rounded,
              iconColor: isDark
                  ? AppColors.taskOverdueDark
                  : AppColors.taskOverdueLight,
              badgeBackgroundColor: isDark
                  ? AppColors.redContainerDark
                  : AppColors.redContainerLight,
              value: '$overdueCount',
              valueColor: isDark
                  ? AppColors.taskOverdueDark
                  : AppColors.taskOverdueLight,
              label: 'Overdue',
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ChatInfoStatCard(
              icon: Icons.check_rounded,
              iconColor: isDark
                  ? AppColors.taskCompletedDark
                  : AppColors.taskCompletedLight,
              badgeBackgroundColor: isDark
                  ? AppColors.greenContainerDark
                  : AppColors.greenContainerLight,
              value: '$completedCount',
              valueColor: isDark
                  ? AppColors.taskCompletedDark
                  : AppColors.taskCompletedLight,
              label: 'Completed',
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ChatInfoStatCard(
              icon: Icons.link_rounded,
              iconColor: AppColors.brandBlue,
              badgeBackgroundColor: isDark
                  ? AppColors.iconContainerDark
                  : AppColors.iconContainerLight,
              value: '$totalCount',
              valueColor: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textTitleLight,
              label: 'Total Links',
            ),
          ),
        ],
      ),
    );
  }
}

