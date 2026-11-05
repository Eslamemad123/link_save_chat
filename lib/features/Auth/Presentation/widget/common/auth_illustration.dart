import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/constatnts/images.dart';

class AuthIllustration extends StatelessWidget {
  const AuthIllustration({
    super.key,
    this.height,
  });

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssets.logo,
        height: height ?? 120.h,
        fit: BoxFit.contain,
      ),
    );
  }
}

