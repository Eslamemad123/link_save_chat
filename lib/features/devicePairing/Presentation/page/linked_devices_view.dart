import 'package:flutter/material.dart';
import '../widget/linked_devices_top_bar.dart';
import '../widget/linked_devices_view_body.dart';

class LinkedDevicesView extends StatelessWidget {
  const LinkedDevicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(
        child: Column(
          children: [
            LinkedDevicesTopBar(),
            Expanded(
              child: LinkedDevicesViewBody(),
            ),
          ],
        ),
      ),
    );
  }
}

