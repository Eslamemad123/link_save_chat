import 'package:flutter/material.dart';
import 'package:link_savw_chat/components/inputs/main_text_form_field.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class CreateChatDescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CreateChatDescriptionField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MainTextFormField(
      controller: controller,
      hint: 'Short description (optional)...',
      maxTextLines: 3,
      onChanged: onChanged,
      colorFill: isDark
          ? AppColors.descriptionFillDark
          : AppColors.descriptionFillLight,
    );
  }
}
