import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsBadge extends StatelessWidget {
  const SettingsBadge({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    this.dotColor,
    this.icon,
    this.borderColor,
    this.padding,
    this.fontSize,
  });

  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color? dotColor;
  final Widget? icon;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1.w)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null) ...[
            Container(
              width: 6.r,
              height: 6.r,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.w),
          ],
          if (icon != null) ...[
            icon!,
            SizedBox(width: 4.w),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? 12.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

