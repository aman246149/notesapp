import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:notetakingapp/Model/Note.dart';
import 'package:notetakingapp/Provider/PinNoteProvider.dart';

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

  Future<void> deleteNotes(
      String docId, BuildContext context, bool isPinned) async {
    print(docId);
    try {
      print(isPinned);
      if (isPinned == false) {
        await _firestore
            .collection("pinNotes")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userIndPinNotes")
            .doc(docId)
            .delete();
        print("delete");
      } else {
        await _firestore
            .collection("Notes")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userIndNotes")
            .doc(docId)
            .delete();
      }

      showSnackBar("Notes Deleted Successfully", context);
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> pinnedNotes(String docId, BuildContext context) async {
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection("Notes")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userIndNotes")
          .doc(docId)
          .get();
      print(snapshot.data());

      await _firestore
          .collection("pinNotes")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userIndPinNotes")
          .add(snapshot.data() as Map<String, dynamic>);

      // await deleteNotes(docId, context);
    } catch (e) {}
  }

  Future<Map<String, dynamic>> getPinnedNote() async {
    List<Note> dataList = [];
    List<String> docIds = [];
    try {
      var data = await _firestore
          .collection("pinNotes")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userIndPinNotes")
          .get();

      for (int i = 0; i < data.docs.length; i++) {
        Note note = Note.fromSnap(data.docs[i]);
        dataList.add(note);
        docIds.add(data.docs[i].id);
      }

      print(docIds);
      print(dataList[0].uid);
      return {"dataList": dataList, "docIdsList": docIds};
    } catch (e) {
      return {"error": e.toString()};
    }
  }
}
