import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_savw_chat/components/inputs/password_visibility_toggle.dart';
import 'package:link_savw_chat/core/utils/colors.dart';
import 'package:link_savw_chat/core/utils/textStyles.dart';

class MainTextFormField extends StatefulWidget {
  const MainTextFormField({
    super.key,
    this.controller,
    this.hint,
    this.maxTextLines = 1,
    this.validator,
    this.ispassword = false,
    this.colorFill,
    this.label,
    this.prefixIcon,
    this.prefixWidget,
    this.sufixIcon,
    this.sufixWidget,
    this.textColor,
    this.textInputNext,
    this.onFieldSubmitted,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
  });

  final TextEditingController? controller;
  final String? hint;
  final int maxTextLines;
  final String? Function(String?)? validator;
  final bool ispassword;
  final Color? colorFill;
  final String? label;
  final String? prefixIcon;
  final Widget? prefixWidget;
  final String? sufixIcon;
  final Widget? sufixWidget;
  final Color? textColor;
  final TextInputAction? textInputNext;
  final void Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  State<MainTextFormField> createState() => _MainTextFormFieldState();
}

class _MainTextFormFieldState extends State<MainTextFormField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.ispassword;
  }

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderRadius = BorderRadius.circular(16.r);

    Widget? prefix;
    if (widget.prefixWidget != null) {
      prefix = widget.prefixWidget;
    } else if (widget.prefixIcon != null) {
      prefix = Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: SvgPicture.asset(
          widget.prefixIcon!,
          width: 20.w,
          height: 20.h,
          fit: BoxFit.scaleDown,
          colorFilter: const ColorFilter.mode(
            AppColors.brandBlue,
            BlendMode.srcIn,
          ),
        ),
      );
    }

    Widget? suffix;
    if (widget.ispassword) {
      suffix = PasswordVisibilityToggle(
        isObscure: _isObscure,
        onPressed: _toggleObscure,
      );
    } else if (widget.sufixWidget != null) {
      suffix = widget.sufixWidget;
    } else if (widget.sufixIcon != null) {
      suffix = Padding(
        padding: EdgeInsets.all(12.r),
        child: SvgPicture.asset(
          widget.sufixIcon!,
          width: 20.w,
          height: 20.h,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: widget.colorFill ??
            (isDark ? AppColors.inputFillDark : AppColors.inputFillLight),
        borderRadius: borderRadius,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 12.r,
                  offset: Offset(0, 4.h),
                ),
              ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.ispassword ? _isObscure : false,
        validator: widget.validator,
        maxLines: widget.ispassword ? 1 : widget.maxTextLines,
        textInputAction: widget.textInputNext,
        onFieldSubmitted: widget.onFieldSubmitted,
        keyboardType: widget.keyboardType,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        style: AppFontStyles.font14RegularInput(context),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: AppFontStyles.font14RegularHint(context),
          labelText: widget.label,
          labelStyle: AppFontStyles.font14RegularHint(context),
          prefixIcon: prefix,
          suffixIcon: suffix,
          filled: true,
          fillColor: AppColors.transparent,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: isDark
                  ? AppColors.cardBorderDark
                  : AppColors.cardBorderLight,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              color: AppColors.brandBlue,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              color: AppColors.error,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              color: AppColors.error,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
