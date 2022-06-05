import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notetakingapp/Model/Note.dart';
import 'package:notetakingapp/Provider/timeProvider.dart';
import 'package:notetakingapp/Resources/Notes_methods.dart';
import 'package:notetakingapp/Screens/InitialScreen.dart';
import 'package:notetakingapp/utils/datetime.dart';
import 'package:provider/provider.dart';

customDialog(BuildContext context, String notes, int colorHexNode) {
  final timeDateProvider = Provider.of<TimeProvider>(context);

  void saveNotesToFirebase() {
    String whenDateIsEmpty = "";
    Map<String, dynamic> whenTimeisEmpty = {};
    if (timeDateProvider.date.isEmpty && //when we dont select date and time
        timeDateProvider.time.isEmpty) {
      whenDateIsEmpty = whenDateIsEMpty();
      timeDateProvider.setDate(whenDateIsEmpty);
      whenTimeisEmpty = whenTimeIsEmpty();
      timeDateProvider.setTime(whenTimeisEmpty);
    } else if (timeDateProvider
            .date.isEmpty && //when we only select time not date
        timeDateProvider.time.isNotEmpty) {
      whenDateIsEmpty = whenDateIsEMpty();
      timeDateProvider.setDate(whenDateIsEmpty);
    } else if (timeDateProvider
            .date.isNotEmpty && // when we only selct date not time
        timeDateProvider.time.isEmpty) {
      whenTimeisEmpty = whenTimeIsEmpty();
      timeDateProvider.setTime(whenTimeisEmpty);
    }

    Note note = Note(
        note: notes,
        colorHexNode: colorHexNode,
        date: timeDateProvider.date,
        time: timeDateProvider.time,
        uid: FirebaseAuth.instance.currentUser!.uid);

    NotesMethods().saveNotesToFirebase(note, context);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: GestureDetector(
              onTap: (() async {
                String date = await selectDate(context);
                timeDateProvider.setDate(date);
              }),
              child: Consumer<TimeProvider>(
                builder: (context, value, child) {
                  return Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xffedf1f3),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: timeDateProvider.date.isEmpty
                                ? Text("Today")
                                : Text(
                                    timeDateProvider.date,
                                    style: TextStyle(color: Colors.black),
                                  ),
                          ),
                          Icon(Icons.calendar_month)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GestureDetector(
              onTap: () async {
                var time = await selectTime(context);
                timeDateProvider.setTime(time);
              },
              child: Consumer<TimeProvider>(
                builder: (context, value, child) {
                  return Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xffedf1f3),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: timeDateProvider.time.isEmpty
                                ? Text("After 5 Mins")
                                : Text(
                                    "After ${value.time["hour"]} hour ${value.time["min"]} Mins"),
                          ),
                          Icon(Icons.punch_clock_rounded)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 48.0),
            child: Row(
              children: [
                Expanded(child: Container()),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: saveNotesToFirebase,
                  child: Text("Save"),
                  style: ElevatedButton.styleFrom(primary: Color(0xffffa447)),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
