import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/components/buttons/main_button.dart';
import 'package:link_savw_chat/components/inputs/main_text_form_field.dart';
import 'package:link_savw_chat/core/constatnts/icons.dart';
import 'package:link_savw_chat/core/extentions/Regix.dart';
import 'package:link_savw_chat/core/extentions/show_dialoges.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/signUp/password_strength_indicator.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/signUp/sign_up_terms_checkbox.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _passwordStrengthNotifier = ValueNotifier<PasswordStrength?>(null);
  final _termsAcceptedNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordStrengthNotifier.dispose();
    _termsAcceptedNotifier.dispose();
    super.dispose();
  }

  void _onPasswordChanged(String value) {
    _passwordStrengthNotifier.value = PasswordStrength.calculate(text: value);
  }

  void _onSignUpPressed() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    if (!_termsAcceptedNotifier.value) {
      showMyDialog(
        context,
        'Please agree to the Terms & Privacy Policy to continue',
        type: DialogType.warning,
      );
      return;
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
            controller: _nameController,
            hint: 'Full Name',
            prefixIcon: AppIcons.user,
            textInputNext: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
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
            textInputNext: TextInputAction.next,
            onChanged: _onPasswordChanged,
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
          PasswordStrengthIndicator(strength: _passwordStrengthNotifier),
          SizedBox(height: 12.h),
          MainTextFormField(
            controller: _confirmPasswordController,
            hint: 'Confirm Password',
            prefixIcon: AppIcons.verify,
            ispassword: true,
            textInputNext: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          ValueListenableBuilder<bool>(
            valueListenable: _termsAcceptedNotifier,
            builder: (context, isAccepted, _) {
              return SignUpTermsCheckbox(
                isChecked: isAccepted,
                onChanged: (val) => _termsAcceptedNotifier.value = val,
              );
            },
          ),
          SizedBox(height: 24.h),
          MainButton(
            buttonText: 'Sign Up',
            onPressed: _onSignUpPressed,
          ),
        ],
      ),
    );
  }
}
