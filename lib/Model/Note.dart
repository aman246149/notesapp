import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String note;
  final int colorHexNode;
  final String date;
  final Map time;
  final String uid;

  Note(
      {required this.note,
      required this.colorHexNode,
      required this.date,
      required this.time,
      required this.uid
      });

  //method convert class into object

  Map<String, dynamic> toJson() {
    return {
      "note": note,
      "colorHexNode": colorHexNode,
      "date": date,
      "time": time,
      "uid":uid
    };
  }

  //converting object into user
  static Note fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data()! as Map<String, dynamic>;

    return Note(
      note: snapshot['note'],
      colorHexNode: snapshot["colorHexNode"],
      date: snapshot["date"],
      time: snapshot["time"],
      uid: snapshot["uid"]
    );
  }
}
