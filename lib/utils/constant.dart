import 'package:flutter/material.dart';

const primaryColor = Colors.white;

var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

showSnackBar(String content, BuildContext context) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(content)));
}
