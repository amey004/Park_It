import 'package:flutter/material.dart';
// import 'package:park_it/backend/backend.dart';
import 'package:park_it/config/theme.dart';


class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    @required this.title,
    @required this.factor,
  }) : super(key: key);

  final String title;
  final double factor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * factor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme2.yellow,
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18),
      ),
    );
  }
}
