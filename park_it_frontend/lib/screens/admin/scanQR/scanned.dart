import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:park_it/config/theme.dart';
import 'package:park_it/screens/admin/homepage/home.dart';

class ScannedData extends StatefulWidget {
  ScannedData({Key key, @required this.result}) : super(key: key);
  final result;
  @override
  _ScannedDataState createState() => _ScannedDataState();
}

class _ScannedDataState extends State<ScannedData> {
  @override
  ScannedData get widget => super.widget;
  String data =
      '{"name":"Sample Name","place":"abc Mall","date":"05/09/21","time":"2 pm","duration":"3 hrs","cost":"Rs. 25","status": "Not Paid"}';
  @override
  void initState() {
    super.initState();
    data = widget.result;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map details = json.decode(data);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Theme2.grey2,
          iconTheme: IconThemeData(color: Palette.blue),
          title: Text(
            "Kuch batao idhar kya likhu",
            style: TextStyle(color: Palette.blue),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: size.height * 0.8,
              color: Theme2.grey2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Name of the Customer:",
                            style: TextStyle(
                              color: Theme2.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          details["name"],
                          style: TextStyle(
                            color: Theme2.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Parking spot: ",
                            style: TextStyle(
                              color: Theme2.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          details["place"],
                          style: TextStyle(
                            color: Theme2.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Date: ",
                            style: TextStyle(
                              color: Theme2.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          details["date"],
                          style: TextStyle(
                            color: Theme2.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Time: ",
                            style: TextStyle(
                              color: Theme2.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          details["time"],
                          style: TextStyle(
                            color: Theme2.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Duration: ",
                            style: TextStyle(
                              color: Theme2.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          details["duration"],
                          style: TextStyle(
                            color: Theme2.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Cost: ",
                            style: TextStyle(
                              color: Theme2.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          details["cost"],
                          style: TextStyle(
                            color: Theme2.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Payment Status: ",
                            style: TextStyle(
                              color: Theme2.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          details["status"],
                          style: TextStyle(
                            color: Theme2.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Theme2.yellow)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminHome()));
                  },
                  child: Text(
                    "Approve",
                    style: TextStyle(color: Theme2.black),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Theme2.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Map getData(String data) {
    Map details = json.decode(data);
    return details;
  }
}
