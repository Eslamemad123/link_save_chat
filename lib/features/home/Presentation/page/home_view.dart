import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/GetIt/gi.dart';
import '../../../../core/routes/navigation.dart';
import '../../../../core/routes/routes.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widget/create_chat/create_chat_bottom_sheet.dart';
import '../widget/home_floating_action_button.dart';
import '../widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => gi<HomeCubit>()..loadChats(),
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.failure &&
              state.errorMessage?.contains('not authenticated') == true) {
            pushAndRemoveUntil(context, Routes.login);
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          floatingActionButton: Builder(
            builder: (fabContext) => HomeFloatingActionButton(
              onPressed: () => CreateChatBottomSheet.show(fabContext),
            ),
          ),
          body: SafeArea(child: HomeViewBody()),
        ),
      ),
    );
  }
}
