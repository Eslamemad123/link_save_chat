import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

import '../../../Data/models/category_model.dart';
import 'create_chat_avatar_picker.dart';
import 'create_chat_categories_bar.dart';
import 'create_chat_category_title.dart';
import 'create_chat_description_field.dart';
import 'create_chat_name_field.dart';

class ChatFormFields extends StatelessWidget {
  final List<CategoryModel> categories;
  final int selectedCategoryIndex;
  final ValueChanged<int> onCategorySelected;
  final VoidCallback? onAddCategory;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final File? imageFile;
  final Uint8List? imageBytes;
  final String? imageUrl;
  final VoidCallback? onCameraTap;
  final ValueChanged<String>? onNameChanged;
  final ValueChanged<String>? onDescriptionChanged;

  const ChatFormFields({
    super.key,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
    this.onAddCategory,
    required this.nameController,
    required this.descriptionController,
    this.imageFile,
    this.imageBytes,
    this.imageUrl,
    this.onCameraTap,
    this.onNameChanged,
    this.onDescriptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CreateChatAvatarPicker(
          icon: Icons.chat_bubble_outline_rounded,
          iconColor: AppColors.brandBlue,
          backgroundColor: isDark
              ? AppColors.avatarBackgroundDark
              : AppColors.avatarBackgroundLight,
          imageFile: imageFile,
          imageBytes: imageBytes,
          imageUrl: imageUrl,
          onCameraTap: onCameraTap,
        ),
        SizedBox(height: 20.h),
        const CreateChatCategoryTitle(),
        CreateChatCategoriesBar(
          categories: categories,
          selectedIndex: selectedCategoryIndex,
          onCategorySelected: onCategorySelected,
          onAddCategory: onAddCategory,
        ),
        SizedBox(height: 16.h),
        CreateChatNameField(
          controller: nameController,
          onChanged: onNameChanged,
        ),
        SizedBox(height: 12.h),
        CreateChatDescriptionField(
          controller: descriptionController,
          onChanged: onDescriptionChanged,
        ),
      ],
    );
  }
}

