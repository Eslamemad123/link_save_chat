import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class CreateChatDragHandle extends StatelessWidget {
  const CreateChatDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Container(
        width: 40.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: isDark ? AppColors.dragHandleDark : AppColors.dragHandleLight,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }
}
