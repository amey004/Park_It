import 'package:flutter/material.dart';
import 'package:park_it/components/input_container.dart';
import 'package:park_it/config/theme.dart';

class RoundedPasswordInput extends StatelessWidget {
  const RoundedPasswordInput({Key key, @required this.hint}) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
        child: TextField(
      cursorColor: Palette.blue,
      obscureText: true,
      decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Palette.red),
          hintText: hint,
          border: InputBorder.none),
    ));
  }
}
