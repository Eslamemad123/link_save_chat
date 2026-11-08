import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/components/inputs/main_text_form_field.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class CreateChatNameField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CreateChatNameField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MainTextFormField(
      controller: controller,
      hint: 'Chat name (e.g. Programming Videos)...',
      onChanged: onChanged,
      sufixWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Icon(
          Icons.edit_outlined,
          size: 20.r,
          color: AppColors.brandBlue,
        ),
      ),
    );
  }
}
