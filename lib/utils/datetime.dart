import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<Map<String, dynamic>> selectTime(BuildContext context) async {
  TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay? pickedTime =
      await showTimePicker(context: context, initialTime: initialTime);

  return {"hour": pickedTime!.hour, "min": pickedTime.minute};
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
  return "";
}
