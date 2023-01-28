import 'package:flutter/material.dart';
import 'package:payzero/component/color.dart';

class TextInput extends StatelessWidget {
  final String placeholder;
  final TextEditingController textEditingController;
  final bool password;
  final bool autoFocus;

  const TextInput(
      {super.key,
      this.autoFocus = false,
      required this.placeholder,
      required this.textEditingController,
      this.password = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      obscureText: password,
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: placeholder,
          label: Text(placeholder),
          labelStyle: TextStyle(color: textColor),
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: textColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor))),
    );
  }
}
