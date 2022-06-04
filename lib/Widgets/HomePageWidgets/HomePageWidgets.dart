import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notetakingapp/Model/Note.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/CustomCards.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/CustomHomeScreenDialog.dart';

class CustomStream extends StatelessWidget {
  final Stream url;
  const CustomStream({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Notes")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userIndNotes")
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshots.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "Create Your First Notes",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          );
        }

        return GridView.custom(
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            pattern: [
              const WovenGridTile(1),
              const WovenGridTile(
                5 / 6,
                crossAxisRatio: 0.9,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: snapshots.data!.docs.length,
            (context, index) {
              Note note = Note.fromSnap(snapshots.data!.docs[index]);
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (dialogContext) => openDialogBox(
                              dialogContext,
                              note,
                              snapshots.data!.docs[index].id,
                              true));
                    },
                    child: CustomCard(note: note)),
              );
            },
          ),
        );
      },
    );
  }
}
