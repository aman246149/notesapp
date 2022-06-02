import 'package:flutter/material.dart';

class CustomContainerColor extends StatelessWidget {
  final int colorValue;
  const CustomContainerColor({
    Key? key,
    required this.colorValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Color(colorValue),
        borderRadius: new BorderRadius.circular(10.0),
      ),
    );
  }
}
