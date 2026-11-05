import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/components/buttons/main_button.dart';
import 'package:link_savw_chat/components/inputs/main_text_form_field.dart';
import 'package:link_savw_chat/core/constatnts/icons.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/routes/routes.dart';
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
    if (_formKey.currentState?.validate() ?? false) {}
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
          ),
          SizedBox(height: 16.h),
          MainTextFormField(
            controller: _passwordController,
            hint: 'Password',
            prefixIcon: AppIcons.lock,
            ispassword: true,
            textInputNext: TextInputAction.done,
          ),
          SizedBox(height: 8.h),
          LoginForgotPasswordButton(
            onPressed: () => pushTo(context, Routes.forgotPassword),
          ),
          SizedBox(height: 20.h),
          MainButton(
            buttonText: 'Log In',
            onPressed: _onLoginPressed,
          ),
        ],
      ),
    );
  }
}
