import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/navigation.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/colors.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'chat_list_view.dart';
import 'home_filter_bar.dart';
import 'home_header.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        SizedBox(height: 8.h),
        const HomeFilterBar(),
        SizedBox(height: 8.h),
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.status == HomeStatus.loading &&
                  state.allChats.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.brandBlue),
                );
              }

              return ChatListView(
                chats: state.filteredChats,
                onRefresh: () => context.read<HomeCubit>().loadChats(),
                onChatTap: (chat) => pushTo(context, Routes.chat, chat),
              );
            },
          ),
        ),
      ],
    );
  }
}
