import 'package:flutter/material.dart';
import 'package:payzero/component/color.dart';
import 'package:payzero/component/input/textfeid.dart';

void popUpAlert(BuildContext context, String titlepage, String placeholder,
    String button, TextEditingController editingController, Function ontap) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            titlepage,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xff181b19)),
          ),
        ),
        content: TextInput(
            placeholder: placeholder,
            autoFocus: true,
            textEditingController: editingController),
        actions: [
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: () {
                () async {
                  await ontap();
                }();

                Navigator.of(context).pop();
              },
              child: Text(
                button,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ]),
  );
}
