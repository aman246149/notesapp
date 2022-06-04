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
  int selectedPage = 0;
  bool isAnyPinnNotes = false;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> pages = [MainHomeScreen(), SearchScreen()];
  @override
  Widget build(BuildContext context) {
    print("build");
    final pinNotesList = Provider.of<PinnedNoteProvider>(context).docIdsList;
    print(pinNotesList);
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
      body: pages[selectedPage],
    );
  }
}
