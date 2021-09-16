import 'package:flutter/material.dart';
import 'package:park_it/components/input_container.dart';
import 'package:park_it/config/theme.dart';


class RoundedInput extends StatelessWidget {
  const RoundedInput({
    Key key,
    @required this.icon,
    @required this.hint
  }) : super(key: key);

  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        cursorColor: Palette.red,
        decoration: InputDecoration(
          icon: Icon(icon, color: Palette.red),
          hintText: hint,
          border: InputBorder.none
        ),
      ));
  }
}