import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notetakingapp/Model/Note.dart';
import 'package:notetakingapp/Provider/PinNoteProvider.dart';

import 'package:notetakingapp/Resources/Notes_methods.dart';
import 'package:notetakingapp/Screens/AddNoteScreen.dart';
import 'package:notetakingapp/Widgets/CustomCards.dart';
import 'package:notetakingapp/Widgets/CustomHomeScreenDialog.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  List<Note> pinned = [];

  @override
  void initState() {
    fetchPinNote();
    super.initState();
  }

  void fetchPinNote() async {
    var mapData = await NotesMethods().getPinnedNote();
    if (mapData["dataList"] == null && mapData["docIdsList"] == null) {
    } else {
      List<Note> pinnote = mapData["dataList"];

      if (!mounted) return;
      Provider.of<PinnedNoteProvider>(context, listen: false)
          .setPinNote(pinnote);
      Provider.of<PinnedNoteProvider>(context, listen: false)
          .setDocumentIdsList(mapData["docIdsList"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final pinNotesList = Provider.of<PinnedNoteProvider>(context).pinNote;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (value) {
            setState(() {
              selectedPage = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                  size: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                label: "")
          ]),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              color: Color(0xffff8d19),
              size: 45,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddNoteScreen()));
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Consumer<PinnedNoteProvider>(
        builder: (context, pinNotesList, child) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Stack(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.yellow,
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.yellow,
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://png.pngtree.com/png-clipart/20220429/original/pngtree-girl-drinking-pearl-milk-tea-cute-cartoon-character-avatar-social-media-png-image_7569060.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    "Reminders",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  pinNotesList.pinNote.length > 0
                      ? Text(
                          "pinned",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )
                      : Container(),
                  pinNotesList.pinNote.length > 0
                      ? SizedBox(
                          height: 10,
                        )
                      : Container(),
                  pinNotesList.pinNote.length > 0
                      ? Container(
                          height: MediaQuery.of(context).size.height / 4.4,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: pinNotesList.pinNote.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  print(pinNotesList.docIdsList[index]);
                                  showDialog(
                                      context: context,
                                      builder: (dialogContext) => openDialogBox(
                                          context,
                                          pinNotesList.pinNote[index],
                                          pinNotesList.docIdsList[index],
                                          false));
                                },
                                child: CustomCard(
                                    note: pinNotesList.pinNote[index]),
                              );
                            },
                          ),
                        )
                      : Container(),
                  pinned.length > 0
                      ? SizedBox(
                          height: 23,
                        )
                      : Container(),
                  const Text(
                    "Upcoming",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: CustomStream(
                    url: FirebaseFirestore.instance
                        .collection("Notes")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("userIndNotes")
                        .snapshots(),
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
