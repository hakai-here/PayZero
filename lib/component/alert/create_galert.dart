import 'package:flutter/material.dart';
import 'package:payzero/component/color.dart';
import 'package:payzero/component/input/textfeid.dart';

void popUpAlert(BuildContext context, String titlepage, String placeholder,
    String button, TextEditingController editingController, Function ontap) {
  bool isloading = false;
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
        content: isloading
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : TextInput(
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
              onPressed: isloading
                  ? null
                  : () async {
                      isloading = true;
                      await ontap();
                      isloading = false;
                      // ignore: use_build_context_synchronously
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
