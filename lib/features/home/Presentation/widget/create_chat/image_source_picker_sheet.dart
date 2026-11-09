import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'create_chat_drag_handle.dart';
import 'image_source_tile.dart';

enum ImageSourceOption { camera, gallery, remove }

class ImageSourcePickerSheet extends StatelessWidget {
  final bool hasImage;
  final ValueChanged<ImageSourceOption> onSelect;

  const ImageSourcePickerSheet({
    super.key,
    required this.hasImage,
    required this.onSelect,
  });

  static Future<ImageSourceOption?> show({
    required BuildContext context,
    bool hasImage = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet<ImageSourceOption>(
      context: context,
      useRootNavigator: true,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => SafeArea(
        child: ImageSourcePickerSheet(
          hasImage: hasImage,
          onSelect: (option) => Navigator.of(ctx).pop(option),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CreateChatDragHandle(),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              'Chat Photo',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          ImageSourceTile(
            icon: Icons.camera_alt_outlined,
            title: 'Take photo',
            onTap: () => onSelect(ImageSourceOption.camera),
          ),
          ImageSourceTile(
            icon: Icons.photo_library_outlined,
            title: 'Choose from gallery',
            onTap: () => onSelect(ImageSourceOption.gallery),
          ),
          if (hasImage)
            ImageSourceTile(
              icon: Icons.delete_outline_rounded,
              title: 'Remove photo',
              iconColor: AppColors.error,
              textColor: AppColors.error,
              onTap: () => onSelect(ImageSourceOption.remove),
            ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

