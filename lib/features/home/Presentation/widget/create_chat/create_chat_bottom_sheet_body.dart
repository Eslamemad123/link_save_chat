import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import '../../../Data/models/category_model.dart';
import 'create_chat_avatar_picker.dart';
import 'create_chat_categories_bar.dart';
import 'create_chat_description_field.dart';
import 'create_chat_drag_handle.dart';
import 'create_chat_header.dart';
import 'create_chat_name_field.dart';
import 'create_chat_submit_button.dart';

class CreateChatBottomSheetBody extends StatelessWidget {
  final List<CategoryModel> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;
  final VoidCallback? onAddCategory;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final VoidCallback? onClosePressed;
  final VoidCallback? onCameraTap;
  final VoidCallback onSubmitPressed;
  final File? imageFile;
  final bool isLoading;

  const CreateChatBottomSheetBody({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
    this.onAddCategory,
    required this.nameController,
    required this.descriptionController,
    this.onClosePressed,
    this.onCameraTap,
    required this.onSubmitPressed,
    this.imageFile,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 12.h),
          const CreateChatDragHandle(),
          SizedBox(height: 12.h),
          CreateChatHeader(
            onClosePressed: onClosePressed,
          ),
          SizedBox(height: 16.h),
          CreateChatAvatarPicker(
            icon: Icons.chat_bubble_outline_rounded,
            iconColor: AppColors.brandBlue,
            backgroundColor: isDark
                ? AppColors.avatarBackgroundDark
                : AppColors.avatarBackgroundLight,
            imageFile: imageFile,
            onCameraTap: onCameraTap,
          ),
          SizedBox(height: 20.h),
          if (categories.isNotEmpty) ...[
            CreateChatCategoriesBar(
              categories: categories,
              selectedIndex: selectedIndex,
              onCategorySelected: onCategorySelected,
              onAddCategory: onAddCategory,
            ),
            SizedBox(height: 16.h),
          ],
          CreateChatNameField(
            controller: nameController,
          ),
          SizedBox(height: 12.h),
          CreateChatDescriptionField(
            controller: descriptionController,
          ),
          SizedBox(height: 20.h),
          CreateChatSubmitButton(
            isLoading: isLoading,
            onPressed: onSubmitPressed,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
