import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/routes/routes.dart';
import 'package:link_savw_chat/features/onBoarding/Data/models/on_boarding_model.dart';
import 'package:link_savw_chat/features/onBoarding/Presentation/widget/on_boarding_action_button.dart';
import 'package:link_savw_chat/features/onBoarding/Presentation/widget/on_boarding_indicator.dart';
import 'package:link_savw_chat/features/onBoarding/Presentation/widget/on_boarding_page_view.dart';
import 'package:link_savw_chat/features/onBoarding/Presentation/widget/on_boarding_top_bar.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onActionButtonPressed() {
    if (_currentIndex == OnBoardingModel.items.length - 1) {
      pushReplacement(context, Routes.login);
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentIndex == OnBoardingModel.items.length - 1;

    return SafeArea(
      child: Column(
        children: [
          OnBoardingTopBar(isLastPage: isLastPage),
          OnBoardingPageView(
            pageController: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: OnBoardingModel.items,
          ),
          OnBoardingIndicator(
            pageController: _pageController,
            count: OnBoardingModel.items.length,
          ),
          SizedBox(height: 32.h),
          OnBoardingActionButton(
            isLastPage: isLastPage,
            onPressed: _onActionButtonPressed,
          ),
          SizedBox(height: 36.h),
        ],
      ),
    );
  }
}
