import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../components/inputs/main_text_form_field.dart';
import '../../../../../core/utils/colors.dart';

class AddCategoryNameField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const AddCategoryNameField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MainTextFormField(
      controller: controller,
      hint: 'Category name (e.g. Work, Study)...',
      onChanged: onChanged,
      sufixWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Icon(
          Icons.category_outlined,
          size: 20.r,
          color: AppColors.brandBlue,
        ),
      ),
    );
  }
}
