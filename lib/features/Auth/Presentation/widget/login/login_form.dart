import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/components/buttons/main_button.dart';
import 'package:link_savw_chat/components/inputs/main_text_form_field.dart';
import 'package:link_savw_chat/core/constatnts/icons.dart';
import 'package:link_savw_chat/core/extentions/Regix.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/routes/routes.dart';
import 'package:link_savw_chat/features/Auth/Presentation/cubit/auth_cubit.dart';
import 'package:link_savw_chat/features/Auth/Presentation/cubit/auth_state.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/login/login_forgot_password_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MainTextFormField(
            controller: _emailController,
            hint: 'Email',
            prefixIcon: AppIcons.email,
            keyboardType: TextInputType.emailAddress,
            textInputNext: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }
              if (!AppRegEx.isEmailValied(value.trim())) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          MainTextFormField(
            controller: _passwordController,
            hint: 'Password',
            prefixIcon: AppIcons.lock,
            ispassword: true,
            textInputNext: TextInputAction.done,
            onFieldSubmitted: (_) => _onLoginPressed(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 8.h),
          LoginForgotPasswordButton(
            onPressed: () => pushTo(context, Routes.forgotPassword),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (prev, curr) =>
                (prev is AuthLoading) != (curr is AuthLoading),
            builder: (context, state) {
              final isEmailLoading = state is AuthLoading &&
                  (state.action == 'email' || state.action == null);
              return MainButton(
                buttonText: 'Log In',
                isLoading: isEmailLoading,
                onPressed: _onLoginPressed,
              );
            },
          ),
        ],
      ),
    );
  }
}
