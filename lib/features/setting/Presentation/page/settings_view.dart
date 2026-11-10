import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/GetIt/gi.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/features/Auth/Presentation/cubit/auth_cubit.dart';
import '../widget/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => gi<AuthCubit>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color:
                  isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
              size: 20.r,
            ),
            onPressed: () => pop(context),
          ),
          title: Text(
            'Settings',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color:
                  isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight,
            ),
          ),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: SettingsViewBody(),
        ),
      ),
    );
  }
}

