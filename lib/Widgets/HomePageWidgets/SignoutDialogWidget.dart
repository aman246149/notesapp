import 'package:flutter/material.dart';
import 'package:notetakingapp/Resources/Auth_methods.dart';

class SignoutDialogWidget extends StatelessWidget {
  const SignoutDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Want to Signout?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: SimpleDialogOption(
                  child: Text(
                    "SignOut",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    await Auth_Methods().signOut();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: SimpleDialogOption(
                  child: Text("Cancel",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ]);
  }
}
