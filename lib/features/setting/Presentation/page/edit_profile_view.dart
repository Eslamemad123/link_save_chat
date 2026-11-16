import 'package:flutter/material.dart';
import '../widget/edit_profile/edit_profile_top_bar.dart';
import '../widget/edit_profile/edit_profile_view_body.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(
        child: Column(
          children: [
            EditProfileTopBar(),
            Expanded(
              child: EditProfileViewBody(),
            ),
          ],
        ),
      ),
    );
  }
}

