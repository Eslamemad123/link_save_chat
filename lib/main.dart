import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_savw_chat/core/routes/routes.dart';
import 'package:link_savw_chat/core/utils/theme.dart';

//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // ...

  // await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  // );
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: Routes.routes,
        );
      },
    );
  }
}
