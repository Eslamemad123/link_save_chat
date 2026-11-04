import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.width,
    this.height,
    this.borderRadius,
    this.alph = 0.35,
    this.backgroundColor,
    this.textStyle,
    this.icon,
  });

  final String buttonText;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? alph;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius ?? 28.r);
    final buttonColor = backgroundColor ?? AppColors.brandBlue;

    return Container(
      width: width ?? double.infinity,
      height: height ?? 54.h,
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: buttonColor.withValues(alpha: alph ?? 0.35),
            blurRadius: 16.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Material(
        color: buttonColor,
        borderRadius: radius,
        child: InkWell(
          onTap: onPressed,
          borderRadius: radius,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  icon!,
                  SizedBox(width: 8.w),
                ],
                Text(
                  buttonText,
                  style: textStyle ?? AppFontStyles.font16BoldButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
