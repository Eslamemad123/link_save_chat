import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/constatnts/images.dart';

class LoginIllustration extends StatelessWidget {
  const LoginIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(AppAssets.logo, height: 140.h, fit: BoxFit.contain),
    );
  }
}
