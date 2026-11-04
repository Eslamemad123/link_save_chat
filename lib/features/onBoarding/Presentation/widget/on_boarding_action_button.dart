import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/components/buttons/main_button.dart';

class OnBoardingActionButton extends StatelessWidget {
  const OnBoardingActionButton({
    super.key,
    required this.isLastPage,
    required this.onPressed,
  });

  final bool isLastPage;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: MainButton(
        buttonText: isLastPage ? 'Get Started 🚀' : 'Next',
        onPressed: onPressed,
      ),
    );
  }
}

