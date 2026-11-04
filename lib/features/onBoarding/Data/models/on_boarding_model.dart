import 'package:link_savw_chat/core/constatnts/animations.dart';

class OnBoardingModel {
  final String animation;
  final String title;
  final String subtitle;

  const OnBoardingModel({
    required this.animation,
    required this.title,
    required this.subtitle,
  });

  static const List<OnBoardingModel> items = [
    OnBoardingModel(
      animation: AppAnimation.onboarding1,
      title: 'Share Links & Tasks in One Tap',
      subtitle:
          'Organize your content into dedicated chats and access your links anytime across phone and laptop seamlessly.',
    ),
    OnBoardingModel(
      animation: AppAnimation.onboarding2,
      title: 'Instant Sync Between Phone & Laptop',
      subtitle:
          'Scan the QR code from your laptop screen to access all your links and tasks instantly without hassle.',
    ),
    OnBoardingModel(
      animation: AppAnimation.onboarding3,
      title: 'Smart Color System for Your Priorities',
      subtitle:
          'Never miss links or tasks again: automatic highlights for overdue items and alerts for important deadlines.',
    ),
  ];
}

