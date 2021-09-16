import 'package:flutter/material.dart';
import 'package:park_it/config/theme.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:park_it/screens/admin/homepage/body.dart';

class AdminNavigationBar extends StatefulWidget {
  @override
  _AdminNavigationBarState createState() => _AdminNavigationBarState();
}

class _AdminNavigationBarState extends State<AdminNavigationBar> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminBody(
        selectedIndex: selectedIndex,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme2.grey2,
        color: Theme2.yellow,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Theme2.black,
          ),
          Icon(
            Icons.qr_code,
            size: 30,
            color: Theme2.black,
          ),
          Icon(
            Icons.person,
            size: 30,
            color:Theme2.black,
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          //Handle button tap
        },
      ),
    );
  }
}
