import 'package:flutter/material.dart';

import 'package:park_it/screens/homepage/home.dart';
import 'package:park_it/screens/homepage/qrcode.dart';
import 'package:park_it/screens/profile/profile.dart';

class Body extends StatefulWidget {
  Body({Key key, @required this.selectedIndex, @required this.bid})
      : super(key: key);
  final selectedIndex;
  final bid;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Body get widget => super.widget;
  int index = 0;
  String bid;

  @override
  void initState() {
    super.initState();
    index = widget.selectedIndex;
    bid = widget.bid;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      index = widget.selectedIndex;
    });
    return buildPage(context, index);
  }

  Widget buildPage(BuildContext context, int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        {
          selectedIndex = 0;
          return HomePage();
        }
      case 1:
        {
          selectedIndex = 1;
          return OpenQR(
            bid: bid,
          );
        }
      case 2:
        {
          selectedIndex = 2;
          return Profile();
        }
    }
    return Container();
  }
}
