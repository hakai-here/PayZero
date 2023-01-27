import 'package:flutter/material.dart';
import 'package:payzero/component/color.dart';

void basicAlert(BuildContext context, String content) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  splashRadius: 19,
                )
              ],
            ),
            const Text(
              "Ooops, looks like there is some error ",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Color(0xff181b19)),
            ),
          ],
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff8c8e8d)),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: TextButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            child: const Text(
              "OK",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        )
      ],
    ),
  );
}
