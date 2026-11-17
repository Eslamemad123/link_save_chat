import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({
    super.key,
    required this.password,
    this.minLength = 8,
  });

  final String password;
  final int minLength;

  double get _progress {
    if (password.isEmpty) return 0;

    const part = 0.2;
    double score = 0;

    if (RegExp(r'[a-z]').hasMatch(password)) score += part;
    if (RegExp(r'[A-Z]').hasMatch(password)) score += part;
    if (RegExp(r'\d').hasMatch(password)) score += part;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(password)) score += part;

    // الطول بيزيد تدريجي لحد minLength
    score += part * (password.length / minLength).clamp(0.0, 1.0);

    return score.clamp(0.0, 1.0);
  }

  ({String label, Color color}) _status(double p) {
    if (p < 0.4) return (label: 'Weak', color: AppColors.passwordWeak);
    if (p < 0.7) return (label: 'Medium', color: AppColors.passwordMedium);
    if (p < 0.99) return (label: 'Good', color: AppColors.passwordGood);
    return (label: 'Strong', color: AppColors.passwordStrong);
  }

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = _progress;
    final status = _status(progress);
    final borderColor = isDark
        ? AppColors.cardBorderDark
        : AppColors.cardBorderLight;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 12.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: borderColor, width: 1.w),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                builder: (context, value, _) {
                  return Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: FractionallySizedBox(
                      widthFactor: value,
                      heightFactor: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: _status(value).color,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            status.label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: status.color,
            ),
          ),
        ],
      ),
    );
  }
}
