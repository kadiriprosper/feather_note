import 'package:feather_note/screens/archive_page.dart';
import 'package:feather_note/widgets/custom_drawer_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainScreenDrawer extends StatelessWidget {
  const MainScreenDrawer({
    super.key,
    required this.drawerKey,
  });

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Feather Note',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            CustomDrawerButton(
              onPressed: () {
                drawerKey.currentState?.closeDrawer();
              },
              icon: const Icon(
                Icons.lightbulb_outlined,
                size: 25,
              ),
              label: 'Notes',
              selected: true,
            ),
            const Spacer(),
            CustomDrawerButton(
              onPressed: () {
                drawerKey.currentState?.closeDrawer();
                Get.to(() => const ArchivePage());
                //TODO: Do some computation here to highlight the archive button
              },
              icon: const Icon(
                Icons.archive_outlined,
                size: 25,
              ),
              label: 'Archive',
              selected: false,
            ),
            CustomDrawerButton(
              onPressed: () {
                drawerKey.currentState?.closeDrawer();
                //TODO: go to the trash page
              },
              icon: Icon(
                MdiIcons.trashCanOutline,
                size: 25,
              ),
              label: 'Trash',
              selected: false,
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add new item to bottom',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Checkbox(
                    value: false,
                    onChanged: (value) {
                      //TODO: write the code to toggle the button
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
            const Center(
              child: Opacity(
                opacity: .3,
                child: Text(
                  'Coder Waters',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
