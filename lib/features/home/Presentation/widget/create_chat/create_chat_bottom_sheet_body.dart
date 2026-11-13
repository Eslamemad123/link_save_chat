import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Data/models/category_model.dart';
import 'chat_form_fields.dart';
import 'create_chat_drag_handle.dart';
import 'create_chat_header.dart';
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
  final Uint8List? imageBytes;
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
    this.imageBytes,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 12.h),
          const CreateChatDragHandle(),
          SizedBox(height: 12.h),
          CreateChatHeader(onClosePressed: onClosePressed),
          SizedBox(height: 16.h),
          ChatFormFields(
            categories: categories,
            selectedCategoryIndex: selectedIndex,
            onCategorySelected: onCategorySelected,
            onAddCategory: onAddCategory,
            nameController: nameController,
            descriptionController: descriptionController,
            imageFile: imageFile,
            imageBytes: imageBytes,
            onCameraTap: onCameraTap,
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
