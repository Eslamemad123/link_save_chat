import 'package:flutter/material.dart';

import '../../../../core/utils/textStyles.dart';

class HomeHeaderTitle extends StatelessWidget {
  final bool isSearchOpen;

  const HomeHeaderTitle({super.key, required this.isSearchOpen});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isSearchOpen,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isSearchOpen ? 0.0 : 1.0,
        child: Text(
          'My Links & Tasks',
          style: AppFontStyles.font24BoldTitle(context),
        ),
      ),
    );
  }
}
