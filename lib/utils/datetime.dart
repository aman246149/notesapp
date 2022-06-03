import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<Map<String, dynamic>> selectTime(BuildContext context) async {
  TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay? pickedTime =
      await showTimePicker(context: context, initialTime: initialTime);
  pickedTime ??= initialTime;
  return {"hour": pickedTime.hour, "min": pickedTime.minute};
}

Future<String> selectDate(BuildContext context) async {
  DateTime selectedDate = DateTime.now();

  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
    var format = DateFormat("MMMM d");
    String datString = format.format(selectedDate).toString();

    return datString;
  }

  var format = DateFormat("MMMM d");
  String rdatString = format.format(selectedDate).toString();

  return rdatString;
}

String whenDateIsEMpty() {
  DateTime selectedDate = DateTime.now();
  var format = DateFormat("MMMM d");
  String rdatString = format.format(selectedDate).toString();

  return rdatString;
}

Map<String, dynamic> whenTimeIsEmpty() {
  TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay? pickedTime = initialTime;
    return {"hour": pickedTime.hour, "min": pickedTime.minute};
}
