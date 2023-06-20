import 'package:feather_note/controller/global_controller.dart';
import 'package:feather_note/helpers/colors.dart';
import 'package:feather_note/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  //1: Init the get storage
  await GetStorage.init();  
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: dayTheme,
      darkTheme: nightTheme,
      home: const SplashScreen(),
    );
  }
}
