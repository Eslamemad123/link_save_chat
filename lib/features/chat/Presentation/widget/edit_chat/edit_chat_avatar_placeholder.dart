import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class EditChatAvatarPlaceholder extends StatelessWidget {
  const EditChatAvatarPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.photo_camera_outlined,
        size: 38.r,
        color: AppColors.brandBlue,
      ),
    );
  }
}

