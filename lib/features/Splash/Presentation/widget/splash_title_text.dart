import 'package:flutter/material.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class SplashTitleText extends StatelessWidget {
  const SplashTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'LinkSync',
      style: AppFontStyles.font28BoldTitle(context),
      textAlign: TextAlign.center,
    );
  }
}
