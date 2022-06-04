import 'package:flutter/material.dart';
import 'package:notetakingapp/Model/Note.dart';
import 'package:notetakingapp/Provider/PinNoteProvider.dart';
import 'package:notetakingapp/Resources/Notes_methods.dart';
import 'package:provider/provider.dart';

openDialogBox(
  BuildContext context,
  Note note,
  String docId,
  bool isPinned,
) {
  final size = MediaQuery.of(context).size;
  final pinNotesList = Provider.of<PinnedNoteProvider>(context);

  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Container(
      height: size.height / 1.8,
      width: size.width / 1,
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    note.date,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "${note.time['hour']} ${note.time['min']}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: SingleChildScrollView(
                child: Text(
                  note.note,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ),
            ),
            Flexible(
              child: Container(),
              flex: 1,
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: isPinned,
                    child: Expanded(
                      child: ElevatedButton(
                        child: Text(
                          "Pin Note",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        onPressed: () async {
                          try {
                            await NotesMethods().pinnedNotes(docId, context);

                            var mapData = await NotesMethods().getPinnedNote();
                            List<Note> pinList = mapData["dataList"];

                            Provider.of<PinnedNoteProvider>(context,
                                    listen: false)
                                .setPinNote(pinList);

                            Provider.of<PinnedNoteProvider>(context,
                                    listen: false)
                                .setDocumentIdsList(mapData["docIdsList"]);

                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onPressed: () async {
                        try {
                          await NotesMethods()
                              .deleteNotes(docId, context, isPinned);
                          if (isPinned == false) {}

                          Navigator.of(context).pop();
                        } catch (e) {}
                      },
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(),
              flex: 1,
            ),
          ],
        ),
      ),
    ),
  );
}
