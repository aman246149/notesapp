import 'package:flutter/material.dart';
import 'package:notetakingapp/Model/Note.dart';

class CustomCard extends StatelessWidget {
  final Note note;

  const CustomCard({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.4,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        color: Color(note.colorHexNode),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${note.note.substring(0, 21)} ..",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 9,
              ),
              Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${note.date}, ${note.time['hour']}:${note.time['min']}"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
