import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/components/buttons/main_button.dart';

class CreateChatSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const CreateChatSubmitButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return MainButton(
      buttonText: 'Create Chat 🚀',
      height: 52.h,
      borderRadius: 26.r,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
