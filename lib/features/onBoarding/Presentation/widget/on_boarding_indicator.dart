import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingIndicator extends StatelessWidget {
  const OnBoardingIndicator({
    super.key,
    required this.pageController,
    required this.count,
  });

  final PageController pageController;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmoothPageIndicator(
        controller: pageController,
        count: count,
        effect: ExpandingDotsEffect(
          activeDotColor: AppColors.brandBlue,
          dotColor: AppColors.brandBlue.withValues(alpha: 0.2),
          dotHeight: 8.h,
          dotWidth: 8.w,
          expansionFactor: 3.5,
          spacing: 6.w,
        ),
      ),
    );
  }
}

