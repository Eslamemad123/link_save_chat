import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class SettingsWallpaperPreview extends StatelessWidget {
  const SettingsWallpaperPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.wallpaperPreviewBgDark
            : AppColors.wallpaperPreviewBgLight,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight,
          width: 1.w,
        ),
      ),
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: _DoodleLinesPainter(
              color: isDark
                  ? AppColors.wallpaperDoodleLineDark
                  : AppColors.wallpaperDoodleLineLight,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 72.w,
                    height: 22.h,
                    decoration: BoxDecoration(
                      color: AppColors.brandBlue,
                      borderRadius: BorderRadius.circular(11.r),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 90.w,
                    height: 22.h,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceDark
                          : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(11.r),
                      boxShadow: isDark
                          ? null
                          : [
                              BoxShadow(
                                color: AppColors.shadowLight,
                                blurRadius: 6.r,
                                offset: Offset(0, 2.h),
                              ),
                            ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DoodleLinesPainter extends CustomPainter {
  const _DoodleLinesPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (var i = 1; i <= 3; i++) {
      final y = size.height * (i / 4);
      final path = Path();
      path.moveTo(0, y);
      path.quadraticBezierTo(
        size.width * 0.25,
        y - 10,
        size.width * 0.5,
        y,
      );
      path.quadraticBezierTo(
        size.width * 0.75,
        y + 10,
        size.width,
        y,
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DoodleLinesPainter oldDelegate) =>
      oldDelegate.color != color;
}

