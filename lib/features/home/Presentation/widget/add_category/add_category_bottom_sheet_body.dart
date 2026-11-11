import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_category_drag_handle.dart';
import 'add_category_header.dart';
import 'add_category_name_field.dart';
import 'add_category_submit_button.dart';

class AddCategoryBottomSheetBody extends StatelessWidget {
  final TextEditingController nameController;
  final VoidCallback? onClosePressed;
  final VoidCallback onSubmitPressed;
  final bool isLoading;

  const AddCategoryBottomSheetBody({
    super.key,
    required this.nameController,
    this.onClosePressed,
    required this.onSubmitPressed,
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
          const AddCategoryDragHandle(),
          SizedBox(height: 12.h),
          AddCategoryHeader(onClosePressed: onClosePressed),
          SizedBox(height: 20.h),
          AddCategoryNameField(controller: nameController),
          SizedBox(height: 24.h),
          AddCategorySubmitButton(
            isLoading: isLoading,
            onPressed: onSubmitPressed,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
