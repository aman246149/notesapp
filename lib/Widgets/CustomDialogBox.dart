import 'package:flutter/material.dart';
import 'package:notetakingapp/Provider/timeProvider.dart';
import 'package:notetakingapp/utils/datetime.dart';
import 'package:provider/provider.dart';

 customDialog(BuildContext context) {
    final timeDateProvider = Provider.of<TimeProvider>(context);
    print("custom ${timeDateProvider.time["hour"]}");
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: GestureDetector(
                onTap: (() async {
                  String date = await selectDate(context);
                  timeDateProvider.setDate(date);
                }),
                child: Consumer<TimeProvider>(
                  builder: (context, value, child) {
                    return Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xffedf1f3),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: timeDateProvider.date.isEmpty
                                  ? Text("Today")
                                  : Text(
                                      timeDateProvider.date,
                                      style: TextStyle(color: Colors.black),
                                    ),
                            ),
                            Icon(Icons.calendar_month)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () async {
                  var time = await selectTime(context);
                  timeDateProvider.setTime(time);
                  print(time["hour"]);
                  print(time["min"]);
                  // setState(
                  //   () {
                  //     globalTime = time;
                  //   },
                  // );
                },
                child: Consumer<TimeProvider>(
                  builder: (context, value, child) {
                    return Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xffedf1f3),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: timeDateProvider.time.isEmpty
                                  ? Text("After 5 Mins")
                                  : Text(
                                      "After ${value.time["hour"]} hour ${value.time["min"]} Mins"),
                            ),
                            Icon(Icons.punch_clock_rounded)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 48.0),
              child: Row(
                children: [
                  Expanded(child: Container()),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Save"),
                    style: ElevatedButton.styleFrom(primary: Color(0xffffa447)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }