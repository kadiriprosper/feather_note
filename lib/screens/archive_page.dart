import 'package:feather_note/controller/note_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final noteController = Get.put(NoteController());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Archive'),
            actions: [
              IconButton(
                splashRadius: 25,
                tooltip: 'Change layout view',
                onPressed: () {
                  //TODO: Write code to change the layout of the note view
                  print('View changed');
                },
                icon: const Icon(Icons.grid_view_rounded),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
