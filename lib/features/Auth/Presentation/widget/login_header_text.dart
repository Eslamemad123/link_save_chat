import 'package:flutter/material.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class LoginHeaderText extends StatelessWidget {
  const LoginHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('LinkSync', style: AppFontStyles.font22BoldTitle(context));
  }
}
