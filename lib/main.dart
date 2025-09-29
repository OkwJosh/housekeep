import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeep/features/authentication/login/screens/login.dart';
import 'package:housekeep/theme/theme.dart';
import 'package:housekeep/utilities/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: true,
      builder: (context) =>  GetMaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, 
        home: LoginScreen()
      ),
    );
  }
}
