import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'category_item_data.dart';
import 'create_chat_avatar_picker.dart';
import 'create_chat_categories_bar.dart';
import 'create_chat_description_field.dart';
import 'create_chat_drag_handle.dart';
import 'create_chat_header.dart';
import 'create_chat_name_field.dart';
import 'create_chat_submit_button.dart';

class CreateChatBottomSheetBody extends StatelessWidget {
  final List<CategoryItemData> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final VoidCallback? onClosePressed;
  final VoidCallback? onCameraTap;
  final VoidCallback onSubmitPressed;

  const CreateChatBottomSheetBody({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
    required this.nameController,
    required this.descriptionController,
    this.onClosePressed,
    this.onCameraTap,
    required this.onSubmitPressed,
  });

  @override
  Widget build(BuildContext context) {
    final selectedCategory = categories[selectedIndex];

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
            icon: selectedCategory.icon,
            iconColor: selectedCategory.accentColor,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? selectedCategory.darkBgColor
                : selectedCategory.lightBgColor,
            onCameraTap: onCameraTap,
          ),
          SizedBox(height: 20.h),
          CreateChatCategoriesBar(
            categories: categories,
            selectedIndex: selectedIndex,
            onCategorySelected: onCategorySelected,
          ),
          SizedBox(height: 16.h),
          CreateChatNameField(
            controller: nameController,
          ),
          SizedBox(height: 12.h),
          CreateChatDescriptionField(
            controller: descriptionController,
          ),
          SizedBox(height: 20.h),
          CreateChatSubmitButton(
            onPressed: onSubmitPressed,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

