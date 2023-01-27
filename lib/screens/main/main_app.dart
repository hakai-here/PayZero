import 'package:flutter/material.dart';
import 'package:payzero/controllers/auth.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        child: Text("Signout"),
        onPressed: () => Auth().signout(),
      )),
    );
  }
}
