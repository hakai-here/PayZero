import 'package:flutter/material.dart';
import 'package:payzero/component/color.dart';

// ignore: must_be_immutable
class TextInput extends StatelessWidget {
  final String placeholder;
  final TextEditingController textEditingController;
  final bool password;
  final bool autoFocus;
  final TextInputType textInputType;
  Widget? prefix;
  Function? onsubmit;

  TextInput(
      {super.key,
      this.onsubmit,
      this.autoFocus = false,
      required this.placeholder,
      required this.textEditingController,
      this.textInputType = TextInputType.name,
      this.password = false,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        onsubmit!();
      },
      keyboardType: textInputType,
      autofocus: autoFocus,
      obscureText: password,
      controller: textEditingController,
      decoration: InputDecoration(
          prefix: prefix,
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
