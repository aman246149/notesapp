import 'package:flutter/foundation.dart';
import 'package:notetakingapp/Model/Note.dart';

class PinnedNoteProvider extends ChangeNotifier {
  List<Note> _pinNote = [];
  List<String> _docIdsList = [];

  //getter
  List<Note> get pinNote => _pinNote;
  List<String> get docIdsList => _docIdsList;

  //setter

  void setPinNote(List<Note> pinNote) {
    print("called");
    _pinNote = pinNote;
    notifyListeners();
  }

  void setDocumentIdsList(List<String> docIdsList) {
    print("from DOcuments ${docIdsList}");
    _docIdsList = docIdsList;
  }
}
