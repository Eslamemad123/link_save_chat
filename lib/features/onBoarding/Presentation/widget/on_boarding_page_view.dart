import 'package:flutter/material.dart';
import 'package:link_savw_chat/features/onBoarding/Data/models/on_boarding_model.dart';
import 'package:link_savw_chat/features/onBoarding/Presentation/widget/on_boarding_page_item.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({
    super.key,
    required this.pageController,
    required this.onPageChanged,
    required this.items,
  });

  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final List<OnBoardingModel> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        onPageChanged: onPageChanged,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return OnBoardingPageItem(item: items[index]);
        },
      ),
    );
  }
}

