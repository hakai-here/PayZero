import 'package:flutter/material.dart';
import 'package:payzero/component/alert/basic_alert.dart';
import 'package:payzero/controllers/auth.dart';
import 'package:payzero/screens/auth/register.dart';

import '../../component/color.dart';
import '../../component/input/textfeid.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void signin() async {
    String email = _email.text;
    String password = _password.text;

    if (email != "" && password != "") {
      String s = await Auth().signinWithEmail(email: email, password: password);
      if (s != 'success') {
        // ignore: use_build_context_synchronously
        basicAlert(context, s);
      }
    } else {
      basicAlert(context,
          "Its seems you forgot to type your username or password . Please enter them");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 82),
                  height: 35.78,
                  child: Image.asset(
                    'assets/image/logo.png',
                  ),
                ),
                const Text(
                  "Let's sign you in.",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Welcome back to PayZero!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff686777)),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextInput(
                  autoFocus: true,
                  placeholder: "Email",
                  textEditingController: _email,
                ),
                const SizedBox(height: 20),
                TextInput(
                  placeholder: "Password",
                  password: true,
                  textEditingController: _password,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.754,
                          color: textColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '|',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: textColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Register(),
                      )),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.754,
                            color: primaryColor),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextButton(
                    onPressed: () => signin(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white),
                    child: const Text(
                      'Log in',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("OR"),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () => Auth().signinWithgoogle(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/image/google.png',
                              height: 24,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sign in with Google",
                              style: TextStyle(color: textColor, fontSize: 16),
                            )
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
