import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/routes/routes.dart';
import 'package:link_savw_chat/features/Auth/Presentation/cubit/auth_cubit.dart';
import 'package:link_savw_chat/features/Auth/Presentation/cubit/auth_state.dart';
import 'settings_logout_button.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess || state is AuthUnauthenticated) {
          pushAndRemoveUntil(context, Routes.login);
        } else if (state is AuthError) {
          showMyDialog(context, state.message, type: DialogType.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Center(
            child: SettingsLogoutButton(
              isLoading: isLoading,
              onPressed: () => context.read<AuthCubit>().logout(),
            ),
          ),
        );
      },
    );
  }
}

