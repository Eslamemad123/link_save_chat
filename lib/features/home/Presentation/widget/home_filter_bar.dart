import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'home_filter_chip_item.dart';

class HomeFilterBar extends StatelessWidget {
  const HomeFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.selectedFilter != current.selectedFilter ||
          previous.allChats != current.allChats,
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              HomeFilterChipItem(
                label: 'All',
                isSelected: state.selectedFilter == HomeFilter.all,
                onTap: () => cubit.changeFilter(HomeFilter.all),
              ),
              SizedBox(width: 8.w),
              HomeFilterChipItem(
                label: 'Overdue',
                isSelected: state.selectedFilter == HomeFilter.overdue,
                count: state.overdueCount,
                badgeColor: AppColors.taskOverdueLight,
                onTap: () => cubit.changeFilter(HomeFilter.overdue),
              ),
              SizedBox(width: 8.w),
              HomeFilterChipItem(
                label: 'Important',
                isSelected: state.selectedFilter == HomeFilter.important,
                count: state.importantCount,
                badgeColor: AppColors.taskImportantLight,
                onTap: () => cubit.changeFilter(HomeFilter.important),
              ),
            ],
          ),
        );
      },
    );
  }
}

