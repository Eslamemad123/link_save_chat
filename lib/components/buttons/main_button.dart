import 'package:flutter/material.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.buttonText,
    this.width,
    this.height,
    required this.onPressed,
    this.borderRadius,
    this.alph = 0.4,
  });
  final double? borderRadius;
  final String buttonText;
  final double? width;
  final double? height;
  final double? alph;

  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15), // مساحة للشادو
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: alph),
              blurRadius: 6,
              offset: const Offset(0, 4), // لتحت فقط
            ),
          ],
        ),
        child: SizedBox(),
      ),
    );
  }
}
