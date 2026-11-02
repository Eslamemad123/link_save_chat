import 'package:flutter/material.dart';

enum DialogType { error, success, warning }

void showMyDialog(
  BuildContext context,
  String message, {
  DialogType type = DialogType.error,
}) {
  final icon = switch (type) {
    DialogType.error => Icons.error_outline,
    DialogType.warning => Icons.warning_amber_outlined,
    DialogType.success => Icons.check_circle_outline,
  };

  final bgColor = switch (type) {
    DialogType.error => Colors.red,
    DialogType.warning => Colors.yellow,
    DialogType.success => Colors.green,
  };

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: (type == DialogType.warning)
                    ? Colors.white
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: '✕',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Expanded(child: /*Lottie.asset(AppAssets.loaderCirclerJSON*/Image.asset('f'))],
      ),
    ),
  );
}
