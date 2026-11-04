import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/features/onBoarding/Presentation/widget/on_boarding_skip_button.dart';

class OnBoardingTopBar extends StatelessWidget {
  const OnBoardingTopBar({
    super.key,
    required this.isLastPage,
  });

  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!isLastPage)
            const OnBoardingSkipButton()
          else
            SizedBox(height: 36.h),
        ],
      ),
    );
  }
}

