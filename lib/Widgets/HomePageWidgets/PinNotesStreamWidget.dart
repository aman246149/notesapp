import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notetakingapp/Model/Note.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/CustomCards.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/CustomHomeScreenDialog.dart';



class PinnedCustomStream extends StatelessWidget {
  const PinnedCustomStream({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Text("...");
          }

          if (snapshots.data!.docs.length <= 0) {
            return Container();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pinned",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                child: ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Note note =
                          Note.fromSnap(snapshots.data!.docs[index]);
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (dialogContext) =>
                                      openDialogBox(
                                          dialogContext,
                                          note,
                                          snapshots
                                              .data!.docs[index].id,
                                          false));
                            },
                            child: CustomCard(note: note)),
                      );
                    }),
              ),
            ],
          );
        },
        stream: FirebaseFirestore.instance
            .collection("pinNotes")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userIndPinNotes")
            .snapshots());
  }
}
