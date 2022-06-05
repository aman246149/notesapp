import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/HomePageWidgets.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/PinNotesStreamWidget.dart';
import 'package:notetakingapp/Widgets/HomePageWidgets/SignoutDialogWidget.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (dialogContext) =>
                                  SignoutDialogWidget());
                        },
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
                      ),
                    )
                  ],
                ),
              ],
            ),
            Text(
              "Reminders",
              style: GoogleFonts.sourceSansPro(
                  fontSize: 34, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 20,
            ),
            PinnedCustomStream(),
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
                  .orderBy("dateTime", descending: true)
                  .snapshots(),
            )),
          ],
        ),
      ),
    );
  }
}
