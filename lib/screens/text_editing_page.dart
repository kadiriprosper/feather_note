import 'package:feather_note/controller/note_controller.dart';
import 'package:feather_note/model/note_model.dart';
import 'package:feather_note/widgets/custom_drawer_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';

class TextEditingPage extends StatefulWidget {
  const TextEditingPage({super.key});

  @override
  State<TextEditingPage> createState() => _TextEditingPageState();
}

class _TextEditingPageState extends State<TextEditingPage> {
  final noteController = Get.put(NoteController());
  late TextEditingController titleController;
  late TextEditingController contentController;
  late NoteModel selectedNote;
  FocusNode contentFocus = FocusNode();

  @override
  void initState() {
    selectedNote = noteController.selectedNote;
    titleController = TextEditingController(text: selectedNote.title);
    contentController = TextEditingController(text: selectedNote.content);
    if (selectedNote.content == '' && selectedNote.title == '') {
      noteController.selectedNoteIndex =
          noteController.allNotes.indexOf(noteController.allNotes.last);
      contentFocus.requestFocus();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            splashRadius: 25,
            tooltip: selectedNote.isPinned
                ? 'unpin'
                : 'Pin', //TODO: Check to see if the note is pinned
            onPressed: () {
              noteController.togglePinnedState();
            },
            icon: selectedNote.isPinned
                ? Icon(MdiIcons.pin)
                : Icon(MdiIcons.pinOutline),
          ),
          IconButton(
            splashRadius: 25,
            tooltip: noteController.isNoteArchived() ? 'unarchive' : 'archive',
            onPressed: () {
              if (!noteController.isNoteArchived()) {
                //After the note is archieved, go back and show snackbar message
                Get.back();
                noteController.archiveNote(noteController.selectedNoteIndex);
                Get.showSnackbar(
                  const GetSnackBar(
                    duration: Duration(seconds: 1),
                    isDismissible: true,
                    message: 'Note archieved and dismissed',
                  ),
                );
              } else {
                noteController.unArchiveNote();
              }
            },
            icon: noteController.isNoteArchived()
                ? const Icon(Icons.archive)
                : const Icon(Icons.archive_outlined),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  titleSpacing: 0,
                  title: TextField(
                    controller: titleController,
                    onChanged: (value) {
                      setState(() {
                        noteController.selectedNote
                            .updateTitle(titleController.text);
                        noteController.updateNote();
                      });
                    },
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        noteController.selectedNote
                            .updateContent(contentController.text);
                        noteController.updateNote();
                      });
                    },
                    focusNode: contentFocus,
                    controller: contentController,
                    // expands: true,
                    maxLines: null,
                    minLines: 1,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Note',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            //
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Colors.transparent,
        elevation: 0,
        child: SizedBox(
          child: Row(
            children: [
              IconButton(
                splashRadius: 25,
                tooltip: 'theme',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const ThemeBottomSheet();
                    },
                  );
                },
                icon: Icon(MdiIcons.paletteOutline),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Edited ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMd().format(selectedNote.noteUpdateTime),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                splashRadius: 25,
                tooltip: 'menu',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const MenuBottomSheet();
                    },
                  );
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuBottomSheet extends StatefulWidget {
  const MenuBottomSheet({
    super.key,
  });

  @override
  State<MenuBottomSheet> createState() => _MenuBottomSheetState();
}

class _MenuBottomSheetState extends State<MenuBottomSheet> {
  final noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      // color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDrawerButton(
            icon: Icon(MdiIcons.trashCanOutline),
            label: 'Delete',
            onPressed: () {
              Get.back();
              Get.back();
              Get.showSnackbar(const GetSnackBar(
                message: 'Note Deleted',
                duration: Duration(seconds: 1),
              ));
              noteController.deleteNote(noteController.selectedNoteIndex);
            },
            selected: false,
          ),
          CustomDrawerButton(
            icon: const Icon(Icons.copy),
            label: 'Make a copy',
            onPressed: () {
              noteController.copyNote(noteController.selectedNoteIndex);
              Get.back();
              Get.showSnackbar(
                const GetSnackBar(
                  message: 'Note Copied',
                  duration: Duration(seconds: 1),
                ),
              );
            },
            selected: false,
          ),
          CustomDrawerButton(
            icon: const Icon(Icons.share_outlined),
            label: 'Share',
            onPressed: () async {
              //TODO: Test this guy on a phone
              await Share.share(
                noteController.selectedNote.title,
                subject: noteController.selectedNote.content,
              );
              Get.back();
            },
            selected: false,
          ),
        ],
      ),
    );
  }
}

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      color: Colors.black,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Background'),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              //TODO: Change the colors to background images
              children: [
                Padding(
                  padding: const EdgeInsets.all(8).copyWith(left: 0, right: 10),
                  child: InkWell(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8).copyWith(left: 0, right: 10),
      child: InkWell(
        onTap: () {},
        child: const CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 23,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 21,
          ),
        ),
      ),
    );
  }
}
