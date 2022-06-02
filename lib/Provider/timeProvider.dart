import 'package:flutter/foundation.dart';

class TimeProvider extends ChangeNotifier {
  Map<String, dynamic> _time = {};
  String _date = "";

  //getters
  Map<String, dynamic> get time => _time;

  String get date => _date;

  //setters
  void setTime(Map<String, dynamic> time) {
    _time = time;
    notifyListeners();
  }

  void setDate(String date) {
    _date = date;
    notifyListeners();
  }
}
