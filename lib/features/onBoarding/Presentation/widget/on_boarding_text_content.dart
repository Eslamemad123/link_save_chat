import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class OnBoardingTextContent extends StatelessWidget {
  const OnBoardingTextContent({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppFontStyles.font22BoldTitle(context),
          ),
          SizedBox(height: 24.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppFontStyles.font16RegularSubtitle(context),
          ),
        ],
      ),
    );
  }
}
