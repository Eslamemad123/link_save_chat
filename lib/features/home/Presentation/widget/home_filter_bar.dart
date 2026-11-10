import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'add_category/add_category_bottom_sheet.dart';
import 'home_add_category_button.dart';
import 'home_filter_chip_item.dart';

class HomeFilterBar extends StatelessWidget {
  const HomeFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.selectedFilter != current.selectedFilter ||
          previous.categories != current.categories ||
          previous.allChats != current.allChats,
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return SizedBox(
          height: 38.h,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                HomeFilterChipItem(
                  label: 'All',
                  isSelected: state.selectedFilter == HomeState.filterAll,
                  count: state.totalUnreadChatCount,
                  onTap: () => cubit.changeFilter(HomeState.filterAll),
                ),
                for (final category in state.categories) ...[
                  SizedBox(width: 8.w),
                  HomeFilterChipItem(
                    label: category.name,
                    isSelected: state.selectedFilter.toLowerCase() ==
                            category.id.toLowerCase() ||
                        state.selectedFilter.toLowerCase() ==
                            category.name.toLowerCase(),
                    count: state.categoryUnreadChatCount(
                      category.id,
                      category.name,
                    ),
                    onTap: () => cubit.changeFilter(category.id),
                  ),
                ],
                SizedBox(width: 8.w),
                HomeAddCategoryButton(
                  onTap: () => AddCategoryBottomSheet.show(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
