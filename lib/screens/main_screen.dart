import 'package:feather_note/controller/global_controller.dart';
import 'package:feather_note/controller/note_controller.dart';
import 'package:feather_note/model/note_model.dart';
import 'package:feather_note/screens/text_editing_page.dart';
import 'package:feather_note/widgets/main_screen_drawer.dart';
import 'package:feather_note/widgets/notes_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final notesController = Get.put(NoteController());
  final drawerKey = GlobalKey<ScaffoldState>();
  final globalController = Get.put(GlobalController());

  @override
  void initState() {
    notesController.initNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      body: Obx(
        () => CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverAppBar(
                centerTitle: true,
                leading: IconButton(
                  splashRadius: 25,
                  tooltip: 'Open navigation drawer',
                  onPressed: () {
                    setState(() {
                      drawerKey.currentState?.openDrawer();
                    });
                  },
                  icon: const Icon(Icons.menu),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                titleSpacing: 0,
                title: const Text(
                  'feather notes🍀',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
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
                  IconButton(
                    splashRadius: 25,
                    tooltip: 'Toggle theme',
                    onPressed: () {
                      globalController.toggleTheme();
                    },
                    icon: Icon(globalController.themeIcon) //Obx(() => Icon(globalController.themeIcon)),
                  ),
                ],
              ),
            ),
            notesController.allNotes.isEmpty
                ? Obx(() => const SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'No Notes Yet 🖊',
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                    ))
                : Obx(
                    () => SliverList.separated(
                      itemCount: notesController.allNotes.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                      itemBuilder: (context, index) {
                        final notes = notesController.allNotes;
                        return Obx(() => NotesListTile(
                              onDismissed: (direction) {
                                notesController.selectedNote = notes[index];
                                notesController.selectedNoteIndex = index;
                                // notesController.archiveNote(index);
                                if (!notesController.isNoteArchived()) {
                                  //After the note is archieved, go back and show snackbar message
                                  notesController.archiveNote(index);
                                  Get.showSnackbar(
                                    const GetSnackBar(
                                      duration: Duration(seconds: 1),
                                      isDismissible: true,
                                      message: 'Note archieved and dismissed',
                                    ),
                                  );
                                } else {
                                  notesController.unArchiveNote();
                                }
                                // Get.showSnackbar(
                                //   const GetSnackBar(
                                //     message: 'Note Archived',
                                //     duration: Duration(seconds: 1),
                                //   ),
                                // );
                              },
                              onLongPress: () {
                                notesController.selectedNote = notes[index];
                                notesController.selectedNoteIndex = index;
                              },
                              note: notes[index],
                              onTap: () {
                                notesController.selectedNote = notes[index];
                                notesController.selectedNoteIndex = index;
                                Get.to(() => const TextEditingPage());
                              },
                            ));
                      },
                    ),
                  ),
          ],
        ),
      ),
      drawer: MainScreenDrawer(
        drawerKey: drawerKey,
      ),
      // bottomNavigationBar: BottomAppBar(
      //   height: 100,
      //   shape: CircularNotchedRectangle(),
      //   notchMargin: 0,
      //   // child: Container(
      //   //   width: double.infinity,
      //   //   height: 20,
      //   // ),
      // ),
      //Todo: check out this notched shape something
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create new note',
        onPressed: () {
          notesController.createNewNote(
            NoteModel(title: '', content: ''),
          );

          Get.to(() => const TextEditingPage());
        },
        child: Icon(
          MdiIcons.plus,
          size: 30,
        ),
      ),
    );
  }
}
