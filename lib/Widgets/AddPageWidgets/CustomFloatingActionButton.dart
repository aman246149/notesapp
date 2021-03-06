import 'package:flutter/material.dart';
import 'package:notetakingapp/utils/constant.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final size;
  final context;
  final Dialog customDialog;
  final String note;

  const CustomFloatingActionButton(
      {Key? key,
      this.size,
      this.context,
      required this.customDialog,
      required this.note})
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
                List<String> arr = note.split(" ");
                if (arr.length < 5) {
                  showSnackBar("Please Enter Atleast 5 Words", context);
                } else {
                  showDialog(
                      context: context, builder: (context) => customDialog);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
