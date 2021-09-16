import 'package:flutter/material.dart';
import 'package:park_it/screens/admin/homepage/home.dart';
import 'package:park_it/screens/admin/profile/profile.dart';
import 'package:park_it/screens/admin/scanQR/scanqr.dart';

class AdminBody extends StatefulWidget {
  AdminBody({Key key, @required this.selectedIndex}) : super(key: key);
  final selectedIndex;

  @override
  _AdminBodyState createState() => _AdminBodyState();
}

class _AdminBodyState extends State<AdminBody> {
  @override
  AdminBody get widget => super.widget;
  int index = 0;
  @override
  void initState() {
    super.initState();
    index = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      index = widget.selectedIndex;
    });
    return buildPage(context, index);
  }
}

Widget buildPage(BuildContext context, int selectedIndex) {
  switch (selectedIndex) {
    case 0:
      {
        selectedIndex = 0;
        return AdminHome();
      }
    case 1:
      {
        selectedIndex = 1;
        return ScanQR();
      }
    case 2:
      {
        selectedIndex = 2;
        return AdminProfile();
      }
  }
  return Container();
}
