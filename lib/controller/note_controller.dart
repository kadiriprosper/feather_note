import 'package:feather_note/data/dummy_data.dart';
import 'package:feather_note/model/note_model.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  final List<NoteModel> _notes = <NoteModel>[].obs;
  final List<NoteModel> _pinnedNotes = <NoteModel>[].obs;
  final List<NoteModel> _archivedNotes = <NoteModel>[].obs;
  final List<NoteModel> _trashedNotes = <NoteModel>[].obs;
  final List<NoteModel> selectedNotes = <NoteModel>[].obs;
  late int selectedNoteIndex = 0;
  late NoteModel selectedNote;

  List<NoteModel> get allNotes {
    return _notes;
  }

  // set setSelectedNoteIndex(int index) {
  //   selectedNoteIndex.value = index;
  // }

  List<NoteModel> get pinnedNotes {
    return _pinnedNotes;
  }

  List<NoteModel> get archivedNotes {
    return _archivedNotes;
  }

  List<NoteModel> get trashedNotes {
    return _trashedNotes;
  }

  void addSelectedNotes(NoteModel note) {
    selectedNotes.add(note);
  }

  void batchDelete() {
    selectedNotes.map((e) => _notes.remove(e));
  }

  void initNotes() {
    const tempData = dummyData;
    for (var values in tempData.values) {
      _notes.add(NoteModel.fromMap(values));
    }
  }

  void createNewNote(NoteModel newNote) {
    // _notes.add(newNote);
    selectedNote = newNote;
    _notes.add(selectedNote);

    // selectedNoteIndex = _notes.indexOf(_notes.last);
    // selectedNoteIndex.update((val) => val = _notes.indexOf(newNote));
  }

  bool togglePinnedState() =>
      _notes[selectedNoteIndex].isPinned = !_notes[selectedNoteIndex].isPinned;

  void addNote() {
    _notes.add(selectedNote);
  }

  void updateNote() {
    selectedNote.title.trimRight();
    selectedNote.content.trimRight();
    if (_notes.contains(selectedNote)) {
      _notes.removeAt(selectedNoteIndex);
      if (selectedNote.noteNotEmpty()) {
        _notes.insert(selectedNoteIndex, selectedNote);
      }
    } else if (_archivedNotes.contains(selectedNote)) {
      _archivedNotes.removeAt(selectedNoteIndex);
      if (selectedNote.noteNotEmpty()) {
        _archivedNotes.insert(selectedNoteIndex, selectedNote);
      }
    } else if (_trashedNotes.contains(selectedNote)) {
      _trashedNotes.removeAt(selectedNoteIndex);
      if (selectedNote.noteNotEmpty()) {
        _trashedNotes.insert(selectedNoteIndex, selectedNote);
      }
    } else {
      _notes.add(selectedNote);
    }
  }

  void copyNote(int index) {
    _notes.add(_notes[index]);
  }

  bool isNoteArchived() {
    return _archivedNotes.contains(selectedNote);
  }

  void archiveNote(int index) {
    _archivedNotes.add(_notes[index]);
    // removeNote(index);
    removeNoteObjext(_notes[index]);
  }

  void unArchiveNote() {
    _notes.add(selectedNote);
    _archivedNotes.remove(selectedNote);
  }

  void pinNote(int index) {
    _pinnedNotes.add(_notes[index]);
  }

  void removeNote(int index) {
    _notes.removeAt(index);
  }

  void removeNoteObjext(NoteModel note) {
    _notes.remove(note);
  }

  void deleteNote(int index) {
    _trashedNotes.add(_notes[index]);
    removeNote(index);
  }
}
