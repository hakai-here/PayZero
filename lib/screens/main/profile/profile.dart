import 'package:flutter/material.dart';
import 'package:payzero/controllers/auth.dart';
import 'package:payzero/controllers/database.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

void func() async {}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text("signout"),
        onPressed: () => Auth().signout(),
      ),
    );
  }
}
