import 'package:feather_note/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GlobalController extends GetxController {
  bool isLightTheme = true;
  IconData themeIcon = MdiIcons.weatherSunny;
  ThemeData currentTheme = nightTheme;

  void toggleTheme() {
    currentTheme = currentTheme == dayTheme ? nightTheme : dayTheme;
    isLightTheme = currentTheme == dayTheme;
    // Get.changeTheme(nightTheme);
    getThemeStatus();
    update();
  }

  void getThemeStatus() =>
      themeIcon = isLightTheme ? MdiIcons.weatherNight : MdiIcons.weatherSunny;
}
