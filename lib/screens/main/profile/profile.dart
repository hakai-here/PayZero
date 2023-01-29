import 'package:flutter/material.dart';
import 'package:payzero/controllers/auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

void func() async {}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text("signout"),
      onPressed: () => Auth().signout(),
    );
  }
}
