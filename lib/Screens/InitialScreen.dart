import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notetakingapp/Model/Note.dart';
import 'package:notetakingapp/Provider/PinNoteProvider.dart';
import 'package:notetakingapp/Resources/Auth_methods.dart';

import 'package:notetakingapp/Resources/Notes_methods.dart';
import 'package:notetakingapp/Screens/AddNoteScreen.dart';
import 'package:notetakingapp/Screens/MainHomeScreen.dart';
import 'package:notetakingapp/Screens/SearchScreen.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/CustomCards.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/CustomHomeScreenDialog.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/HomePageWidgets.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/PinNotesStreamWidget.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/SignoutDialogWidget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  bool isAnyPinnNotes = false;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> pages = [MainHomeScreen(), MainHomeScreen(), SearchScreen()];
  @override
  Widget build(BuildContext context) {
    print("build");
    final pinNotesList = Provider.of<PinnedNoteProvider>(context).docIdsList;
    print(pinNotesList);
    return Scaffold(
      bottomNavigationBar: buildMyNavBar(context),
      // floatingActionButton: ClipRRect(
      //   borderRadius: BorderRadius.circular(80),
      //   child: Container(
      //     color: Colors.white,
      //     padding: EdgeInsets.all(8),
      //     child: FloatingActionButton(
      //       backgroundColor: Colors.white,
      //       child: const Icon(
      //         Icons.add,
      //         color: Color(0xffff8d19),
      //         size: 45,
      //       ),
      //       onPressed: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => AddNoteScreen()));
      //       },
      //     ),
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: pages[pageIndex],
    );
  }

  Stack buildMyNavBar(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: 25,
          bottom: 0,
          child: Card(
            elevation: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xfff4f2f1),
                // gradient: LinearGradient(
                //     colors: [Color(0Xfffbefe4), Color(0Xfffbefe4)],
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 0;
                      });
                    },
                    icon: pageIndex == 0
                        ? const Icon(
                            Icons.menu_rounded,
                            color: Colors.black,
                            size: 35,
                          )
                        : const Icon(
                            Icons.menu_outlined,
                            color: Colors.black,
                            size: 35,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0, right: 38),
                    child: Stack(
                      children: [
                        IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            setState(() {
                              pageIndex = 1;
                            });
                          },
                          icon: pageIndex == 1 ? Container() : Container(),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 2;
                      });
                    },
                    icon: pageIndex == 2
                        ? const Icon(
                            Icons.search_rounded,
                            color: Colors.black,
                            size: 35,
                          )
                        : const Icon(
                            Icons.search_outlined,
                            color: Colors.black,
                            size: 35,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 2.59),
          child: Container(
            height: 100,
            width: 100,
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.add,
                          color: Color(0xffff8d19),
                          size: 55,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddNoteScreen()));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
