import 'package:flutter/material.dart';
import '../../../../core/constatnts/images.dart';
import '../../../../core/utils/colors.dart';

class ChatBackgroundWallpaper extends StatelessWidget {
  const ChatBackgroundWallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Positioned.fill(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.chatBackground,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
          ),
          Container(
            color: isDark
                ? AppColors.chatWallpaperOverlayDark
                : AppColors.chatWallpaperOverlayLight,
          ),
        ],
      ),
    );
  }
}

