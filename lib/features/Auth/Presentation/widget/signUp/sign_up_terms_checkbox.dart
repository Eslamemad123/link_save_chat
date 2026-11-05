import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';
import 'package:link_savw_chat/features/Auth/Presentation/widget/signUp/sign_up_checkbox_box.dart';

class SignUpTermsCheckbox extends StatelessWidget {
  const SignUpTermsCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
    this.onTermsPressed,
  });

  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onTermsPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SignUpCheckboxBox(isChecked: isChecked),
          SizedBox(width: 10.w),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'I agree to the ',
                style: AppFontStyles.font14RegularSubtitle(context),
                children: [
                  TextSpan(
                    text: 'Terms & Privacy Policy',
                    style: AppFontStyles.font14BoldPrimary(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

