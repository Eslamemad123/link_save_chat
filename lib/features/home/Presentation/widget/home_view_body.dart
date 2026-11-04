import 'package:flutter/material.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home',
        style: AppFontStyles.font22BoldTitle(context),
      ),
    );
  }
}

