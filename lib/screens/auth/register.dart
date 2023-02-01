import 'package:flutter/material.dart';
import 'package:payzero/component/alert/basic_alert.dart';
import 'package:payzero/component/color.dart';
import 'package:payzero/component/input/textfeid.dart';
import 'package:payzero/controllers/auth.dart';
import 'package:payzero/screens/main/main_app.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  bool ispassword = true;
  @override
  void initState() {
    super.initState();
    _email.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _username.dispose();
  }

  void signin() async {
    String email = _email.text;
    String password = _password.text;
    String username = _username.text;

    if (email != "" && password != "" && username != "") {
      String s = await Auth()
          .createUserwith(username: username, email: email, password: password);
      if (s != "success") {
        // ignore: use_build_context_synchronously
        basicAlert(context, s);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Mainpage()));
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
                  "Let's get you in ",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Welcome to PayZero, for managing your money!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff686777)),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextInput(
                  placeholder: "Username",
                  textEditingController: _username,
                  autoFocus: true,
                ),
                const SizedBox(height: 20),
                TextInput(
                  placeholder: "Email",
                  textEditingController: _email,
                ),
                const SizedBox(height: 20),
                TextInput(
                  password: ispassword,
                  placeholder: "Password",
                  textEditingController: _password,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account",
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
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        "Log in",
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
                      'Register',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
