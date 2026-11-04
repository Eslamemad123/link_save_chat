import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/features/onBoarding/Data/models/on_boarding_model.dart';
import 'package:link_savw_chat/features/onBoarding/Presentation/widget/on_boarding_animation.dart';
import 'package:link_savw_chat/features/onBoarding/Presentation/widget/on_boarding_text_content.dart';

class OnBoardingPageItem extends StatelessWidget {
  const OnBoardingPageItem({super.key, required this.item});

  final OnBoardingModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        OnBoardingAnimation(animationPath: item.animation),
        SizedBox(height: 32.h),
        //const Spacer(),
        OnBoardingTextContent(title: item.title, subtitle: item.subtitle),
        const Spacer(),
      ],
    );
  }
}
