import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:notetakingapp/Model/Note.dart';
import 'package:notetakingapp/Provider/NotesProvider.dart';
import 'package:notetakingapp/utils/constant.dart';
import 'package:provider/provider.dart';

class NotesMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveNotesToFirebase(Note note, BuildContext context) async {
    try {
      await _firestore
          .collection("Notes")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userIndNotes")
          .add(note.toJson());

      showSnackBar("Notes Saved SuccessFully", context);
    } catch (e) {
      showSnackBar("Some Error Occurd", context);
    }
  }

  Future<List<Note>> getNotesFromFirebase(BuildContext context) async {
    List<Note> noteList = [];

    try {
      var documents = await _firestore
          .collection("Notes")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userIndNotes")
          .get();

      for (int i = 0; i < documents.docs.length; i++) {
        Note note = Note.fromSnap(documents.docs[i]);
        noteList.add(note);
      }
      return noteList;
    } catch (e) {
      showSnackBar(e.toString(), context);
      return noteList;
    }
  }
}
