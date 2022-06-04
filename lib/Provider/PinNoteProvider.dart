import 'package:flutter/foundation.dart';
import 'package:notetakingapp/Model/Note.dart';

class PinnedNoteProvider extends ChangeNotifier {
  List<Note> _pinNote = [];
  List<String> _docIdsList = [];
  bool _isLoading = false;

  //getter
  List<Note> get pinNote => _pinNote;
  List<String> get docIdsList => _docIdsList;
  bool get isLoading => _isLoading;

  //setter

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setPinNote(List<Note> pinNote) {
    print("called");
    _pinNote = pinNote;
    notifyListeners();
  }

  void setDocumentIdsList(List<String> docIdsList) {
    print("from DOcuments ${docIdsList}");
    _docIdsList = docIdsList;
    notifyListeners();
  }
}
