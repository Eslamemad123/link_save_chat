import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/GetIt/gi.dart';
import '../cubit/home_cubit.dart';
import '../widget/home_floating_action_button.dart';
import '../widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => gi<HomeCubit>()..loadChats(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: HomeFloatingActionButton(
          onPressed: () {},
        ),
        body: SafeArea(
          child: HomeViewBody(
            onSettingsPressed: () {},
            onSearchPressed: () {},
          ),
        ),
      ),
    );
  }
}
