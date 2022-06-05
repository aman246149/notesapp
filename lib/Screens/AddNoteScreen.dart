// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notetakingapp/Provider/timeProvider.dart';
import 'package:notetakingapp/Widgets/AddPageWidgets/CustomColorBox.dart';
import 'package:notetakingapp/Widgets/AddPageWidgets/CustomDialogBox.dart';
import 'package:notetakingapp/Widgets/AddPageWidgets/CustomFloatingActionButton.dart';
import 'package:notetakingapp/utils/datetime.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController _noteController = TextEditingController();
  bool selectedColor = false;
  int selectedColorCode = 0xffffa447;

  List<Map<String, dynamic>> colors = [
    {"color": 0xffffa447, "isChecked": true},
    {"color": 0xff7ecbff, "isChecked": false},
    {"color": 0xffffa6c4, "isChecked": false},
    {"color": 0xff1eccc3, "isChecked": false},
    {"color": 0xffffa3a3, "isChecked": false},
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: CustomFloatingActionButton(
          note: _noteController.text,
          context: context,
          size: size,
          customDialog:
              customDialog(context, _noteController.text, selectedColorCode),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: false,
        body: Container(
          // color: Colors.amber,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.arrow_back)),
                      Row(
                        children: const [
                          Icon(Icons.pin),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.notifications),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.menu),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Cookies",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 0, right: 0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.200000000,
                    // color: Colors.green,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            controller: _noteController,
                            autofocus: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Add Note',
                                hintStyle: TextStyle(fontSize: 20)),
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,

                            // cursorHeight: 50,
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 120,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      elevation: 5,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: colors.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 30.0,
                                              bottom: 30,
                                              left: 20,
                                            ),
                                            child: GestureDetector(
                                              onTap: (() {
                                                print(index);
                                              }),
                                              child: Stack(
                                                children: [
                                                  CustomContainerColor(
                                                    colorValue: colors[index]
                                                        ["color"],
                                                  ),
                                                  Checkbox(
                                                    value: colors[index]
                                                        ["isChecked"],
                                                    onChanged: (value) => {
                                                      for (var i in colors)
                                                        {
                                                          if (i.containsValue(
                                                              true))
                                                            {
                                                              i["isChecked"] =
                                                                  false
                                                            }
                                                        },
                                                      setState(() {
                                                        colors[index]
                                                                ["isChecked"] =
                                                            value!;
                                                      }),
                                                      selectedColorCode =
                                                          colors[index]
                                                              ["color"],
                                                      print(selectedColorCode
                                                          .toString())
                                                    },
                                                    fillColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .transparent),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
