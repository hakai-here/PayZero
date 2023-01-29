import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payzero/component/color.dart';
import 'package:payzero/controllers/auth.dart';
import 'package:payzero/screens/auth/signin.dart';
import 'package:payzero/screens/main/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PayZero',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: primaryColor,
        ),
        home: StreamBuilder(
          stream: Auth().authStateChange,
          builder: (context, snapshot) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              child: snapshot.hasData ? const Mainpage() : const Login(),
            );
          },
        ));
  }
}


/*
 // if (snapshot.connectionState == ConnectionState.active) {
            //   if (snapshot.hasData) {
            //     return const Mainpage();
            //   }
            // }
            // return const Login();
 2.11.23
 */