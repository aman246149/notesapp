import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notetakingapp/Model/Note.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/CustomCards.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/CustomHomeScreenDialog.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  bool isShowUser = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
                labelText: 'Search for a Note...',
                labelStyle: TextStyle(color: Colors.black)),
            onChanged: (String val) {
              setState(() {
                isShowUser = true;
              });
            },
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUser = true;
              });
            },
          ),
        ),
        body: isShowUser
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Notes")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("userIndNotes")
                    .where('note', isGreaterThanOrEqualTo: _controller.text)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
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
              )
            : Center(
                child: Text("Search For Your Note"),
              ));
  }
}
