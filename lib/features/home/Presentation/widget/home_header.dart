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
    final iconColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textTitleLight;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SizedBox(
        height: 52.h.clamp(52.0, 64.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final buttonWidth = 44.w.clamp(40.0, 48.0);
            final spacingWidth = 10.w.clamp(8.0, 16.0);
            final reservedWidth = buttonWidth + spacingWidth + 8.0;
            final availableWidth = constraints.maxWidth - reservedWidth;
            final maxSearchWidth = availableWidth > 420.0
                ? 420.0
                : availableWidth.clamp(0.0, availableWidth);
            final shouldHideTitle = _isSearchOpen && constraints.maxWidth < 720;

            return Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: HomeHeaderTitle(isSearchOpen: shouldHideTitle),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: HomeHeaderSearchBar(
                          searchBoxWidth: maxSearchWidth,
                          onToggle: (isOpen) {
                            setState(() {
                              _isSearchOpen = isOpen;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: spacingWidth),
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
            );
          },
        ),
      ),
    );
  }
}
