import 'package:flutter/foundation.dart';
import 'package:notetakingapp/Model/Note.dart';

class NotesProvider extends ChangeNotifier {
  List<Note> _notesList = [];

  //getter
  List<Note> get notesList => _notesList;

  //setter
  void setNotesList(List<Note> notesList) {
    _notesList = notesList;
    notifyListeners();
  }
}
