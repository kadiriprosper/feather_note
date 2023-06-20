import 'package:feather_note/helpers/colors.dart';
import 'package:feather_note/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
            (route) => false,
          ),
        ),
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  MdiIcons.feather,
                  size: MediaQuery.of(context).size.width / 3,
                  color: CustomColors.primaryColor,
                ),
                Text(
                  'Feather Notes',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Colors.brown.shade200,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
