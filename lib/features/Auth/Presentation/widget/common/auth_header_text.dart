import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class AuthHeaderText extends StatelessWidget {
  const AuthHeaderText({
    super.key,
    required this.title,
    required this.subtitle,
    this.spacing,
    this.titleStyle,
    this.subtitleStyle,
    this.subtitlePadding,
  });

  final String title;
  final String subtitle;
  final double? spacing;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsetsGeometry? subtitlePadding;

  @override
  Widget build(BuildContext context) {
    Widget subtitleWidget = Text(
      subtitle,
      textAlign: TextAlign.center,
      style: subtitleStyle ?? AppFontStyles.font14RegularSubtitle(context),
    );

    if (subtitlePadding != null) {
      subtitleWidget = Padding(
        padding: subtitlePadding!,
        child: subtitleWidget,
      );
    }

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: titleStyle ?? AppFontStyles.font22BoldTitle(context),
        ),
        SizedBox(height: spacing ?? 6.h),
        subtitleWidget,
      ],
    );
  }
}

