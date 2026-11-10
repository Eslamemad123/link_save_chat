import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../components/buttons/main_button.dart';

class AddCategorySubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const AddCategorySubmitButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return MainButton(
      buttonText: 'Add Category',
      height: 50.h,
      borderRadius: 25.r,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}

