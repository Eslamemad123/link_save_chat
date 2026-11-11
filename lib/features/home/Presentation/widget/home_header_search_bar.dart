import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../../../../core/constatnts/icons.dart';
import '../../../../core/utils/colors.dart';
import '../cubit/home_cubit.dart';

class _SafeTextEditingController extends TextEditingController {
  bool _isDisposed = false;

  @override
  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;
    super.dispose();
  }
}

class HomeHeaderSearchBar extends StatefulWidget {
  final ValueChanged<bool>? onToggle;
  final double? searchBoxWidth;

  const HomeHeaderSearchBar({super.key, this.onToggle, this.searchBoxWidth});

  @override
  State<HomeHeaderSearchBar> createState() => _HomeHeaderSearchBarState();
}

class _HomeHeaderSearchBarState extends State<HomeHeaderSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _SafeTextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    context.read<HomeCubit>().searchChats(query);
  }

  void _handleClose() {
    _controller.clear();
    _handleSearch('');
    widget.onToggle?.call(false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textTitleLight;
    final searchBoxWidth =
        widget.searchBoxWidth ??
        (MediaQuery.sizeOf(context).width - 86.w).clamp(160.w, 420.w);

    return SearchBarAnimation(
      textEditingController: _controller,
      isOriginalAnimation: false,
      enableKeyboardFocus: true,
      isSearchBoxOnRightSide: true,
      durationInMilliSeconds: 300,
      searchBoxWidth: searchBoxWidth,
      hintText: 'Search...',
      searchBoxColour: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      buttonColour: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      cursorColour: AppColors.brandBlue,
      hintTextColour: isDark
          ? AppColors.textSecondaryDark
          : AppColors.textSubtitleLight,
      searchBoxBorderColour: isDark
          ? AppColors.cardBorderDark
          : AppColors.cardBorderLight,
      buttonBorderColour: isDark
          ? AppColors.cardBorderDark
          : AppColors.cardBorderLight,
      buttonShadowColour: AppColors.shadowLight,
      enableBoxBorder: true,
      enableButtonBorder: true,
      enableButtonShadow: true,
      enableBoxShadow: false,
      enteredTextStyle: TextStyle(
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        fontSize: 14.sp,
      ),
      onPressButton: (isOpen) {
        widget.onToggle?.call(isOpen);
        if (!isOpen) {
          _handleClose();
        }
      },
      onChanged: (value) => _handleSearch(value.toString()),
      onFieldSubmitted: (value) => _handleSearch(value.toString()),
      onCollapseComplete: _handleClose,
      onExpansionComplete: () => widget.onToggle?.call(true),
      trailingWidget: SvgPicture.asset(
        AppIcons.search,
        width: 20.w,
        height: 20.h,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
      secondaryButtonWidget: Icon(Icons.close, size: 20.r, color: iconColor),
      buttonWidget: SvgPicture.asset(
        AppIcons.search,
        width: 20.w,
        height: 20.h,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
    );
  }
}
