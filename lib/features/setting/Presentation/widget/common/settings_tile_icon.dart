import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsTileIcon extends StatelessWidget {
  const SettingsTileIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    this.size,
    this.iconSize,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double? size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final boxSize = size ?? 40.r;

    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize ?? 22.r,
        ),
      ),
    );
  }
}

