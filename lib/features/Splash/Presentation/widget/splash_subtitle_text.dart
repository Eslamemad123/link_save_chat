import 'package:flutter/material.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class SplashSubtitleText extends StatelessWidget {
  const SplashSubtitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sync & Tasks',
      style: AppFontStyles.font13MediumSubtitle(context),
      textAlign: TextAlign.center,
    );
  }
}
