import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/routes/routes.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Home',
            style: AppFontStyles.font22BoldTitle(context),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                pushAndRemoveUntil(context, Routes.login);
              }
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}

