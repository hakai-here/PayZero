import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
        theme: ThemeData.light(),
        home: StreamBuilder(
          stream: Auth().authStateChange,
          builder: (context, snapshot) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
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
 */