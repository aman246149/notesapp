import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final size;
  final context;
  final StatefulBuilder customDialog;

  const CustomFloatingActionButton(
      {Key? key, this.size, this.context, required this.customDialog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: size.height / 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.check,
                color: Color(0xffff8d19),
                size: 45,
              ),
              onPressed: () {
                showDialog(
                    context: context, builder: (context) => customDialog);
              },
            ),
          ),
        ),
      ),
    );
  }
}
