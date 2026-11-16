import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'connected_devices_section.dart';
import 'linked_devices_banner_section.dart';

class LinkedDevicesViewBody extends StatelessWidget {
  const LinkedDevicesViewBody({
    super.key,
    this.onLinkDeviceTap,
    this.onLogoutDevice,
  });

  final VoidCallback? onLinkDeviceTap;
  final ValueChanged<String>? onLogoutDevice;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          LinkedDevicesBannerSection(
            onLinkDeviceTap: onLinkDeviceTap,
          ),
          SizedBox(height: 16.h),
          ConnectedDevicesSection(
            onLogoutDevice: onLogoutDevice,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

