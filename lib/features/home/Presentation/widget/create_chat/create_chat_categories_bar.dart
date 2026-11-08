import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'category_item_data.dart';
import 'create_chat_category_chip.dart';

class CreateChatCategoriesBar extends StatelessWidget {
  final List<CategoryItemData> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const CreateChatCategoriesBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CreateChatCategoryChip(
            category: category,
            isSelected: index == selectedIndex,
            onTap: () => onCategorySelected(index),
          );
        },
      ),
    );
  }
}

