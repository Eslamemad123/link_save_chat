import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/utils/colors.dart';

class SettingsColorPickerRow extends StatefulWidget {
  const SettingsColorPickerRow({
    super.key,
    this.initialIndex = 4,
    this.onColorSelected,
  });

  final int initialIndex;
  final ValueChanged<int>? onColorSelected;

  static const List<Color> colors = [
    AppColors.colorOptionRed,
    AppColors.colorOptionOrange,
    AppColors.colorOptionPurple,
    AppColors.colorOptionGreen,
    AppColors.colorOptionBlue,
  ];

  @override
  State<SettingsColorPickerRow> createState() => _SettingsColorPickerRowState();
}

class _SettingsColorPickerRowState extends State<SettingsColorPickerRow> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(SettingsColorPickerRow.colors.length, (index) {
        final color = SettingsColorPickerRow.colors[index];
        final isSelected = index == _selectedIndex;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
            widget.onColorSelected?.call(index);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Container(
              width: 32.r,
              height: 32.r,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(
                        color: color,
                        width: 3.w,
                      )
                    : null,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: color.withValues(alpha: 0.4),
                          blurRadius: 8.r,
                          offset: Offset(0, 2.h),
                        ),
                      ]
                    : null,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check_rounded,
                      color: AppColors.white,
                      size: 18.r,
                    )
                  : null,
            ),
          ),
        );
      }),
    );
  }
}

