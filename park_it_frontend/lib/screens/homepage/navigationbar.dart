import 'package:flutter/material.dart';
import 'package:park_it/config/theme.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:park_it/screens/homepage/body.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key key, @required this.selectedIndex, @required this.bid})
      : super(key: key);
  final selectedIndex;
  final bid;

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  NavigationBar get widget => super.widget;
  int selectedIndex = 0;
  String bid;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
    bid = widget.bid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        selectedIndex: selectedIndex,
        bid: bid,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme2.yellow,
        backgroundColor: Theme2.grey2,
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
            color: Theme2.black ,
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
