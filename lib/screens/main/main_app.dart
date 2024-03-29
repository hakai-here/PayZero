import 'package:flutter/material.dart';
import 'package:payzero/component/color.dart';
import 'package:payzero/screens/main/groups/group_list.dart';
import 'package:payzero/screens/main/home/home.dart';
import 'package:payzero/screens/main/management/transation.dart';
import 'package:payzero/screens/main/profile/profile.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int currentIndex = 0;

  final screen = const [
    Home(),
    Transation(),
    Groups(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: currentIndex,
            children: screen,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Expense'),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: "Groups"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ],
          currentIndex: currentIndex,
          onTap: (value) => setState(() {
            currentIndex = value;
          }),
          selectedItemColor: primaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          iconSize: 26,
          backgroundColor: Colors.white,
        ));
  }
}
