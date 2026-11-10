import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_savw_chat/core/routes/navigation.dart';
import 'package:link_savw_chat/core/routes/routes.dart';

import '../../../../core/constatnts/icons.dart';
import '../../../../core/utils/colors.dart';
import 'home_header_icon_button.dart';
import 'home_header_search_bar.dart';
import 'home_header_title.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  bool _isSearchOpen = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textTitleLight;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SizedBox(
        height: 52.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: HomeHeaderTitle(isSearchOpen: _isSearchOpen),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HomeHeaderSearchBar(
                    onToggle: (isOpen) {
                      setState(() {
                        _isSearchOpen = isOpen;
                      });
                    },
                  ),
                  SizedBox(width: 10.w),
                  HomeHeaderIconButton(
                    onTap: () => pushTo(context, Routes.settings),
                    icon: SvgPicture.asset(
                      AppIcons.setting,
                      width: 20.w,
                      height: 20.h,
                      colorFilter: ColorFilter.mode(
                        iconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
