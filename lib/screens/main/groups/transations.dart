import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:payzero/component/color.dart';
import 'package:payzero/component/input/textfeid.dart';
import 'package:payzero/controllers/database.dart';
import 'package:payzero/screens/main/profile/profile.dart';

class Transations extends StatefulWidget {
  final String groupId;
  const Transations({super.key, required this.groupId});

  @override
  State<Transations> createState() => _TransationsState();
}

class _TransationsState extends State<Transations> {
  double totalB = 0;
  double sendB = 0;
  double reciveB = 0;
  final TextEditingController amnt = TextEditingController();
  final TextEditingController desc = TextEditingController();

  var textEditingControllers = <TextEditingController>[];
  var textFields = <TextField>[];
  Stream? stream;
  @override
  void initState() {
    getMembers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    amnt.dispose();
    desc.dispose();
  }

  getMembers() async {
    await Datamethod().getMembers(widget.groupId).then((value) {
      stream = value;
    });
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    var container = Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 25,
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                budget(totalB, "Balance", Colors.black),
                const SizedBox(
                  width: 10,
                ),
                budget(sendB, "Will Send", Colors.green),
                budget(reciveB, "Will Recive", Colors.red)
              ]),
        ));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          moneyPopup();
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [container],
        ),
      ),
    );
  }

  Widget budget(double cnt, String what, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "₹ $cnt",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: color),
        ),
        Text(
          what,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  void moneyPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Enter the amount",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextInput(
            placeholder: "Amount",
            prefix: const Text("₹ "),
            autoFocus: true,
            textEditingController: amnt,
            textInputType: TextInputType.number,
            onsubmit: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          TextInput(
            placeholder: "Description",
            textEditingController: desc,
            onsubmit: () {},
          )
        ]),
        actions: [
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                listUsers();
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: const Text(
                "Next",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }

  void listUsers() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Split users"),
              content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                    stream: stream,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data['members'] != null) {
                          if (snapshot.data['members'].length != 0) {
                            return ListView.builder(
                              itemCount: snapshot.data['members'].length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: ProfilePicture(
                                    name: getName(
                                        snapshot.data['members'][index]),
                                    radius: 20,
                                    fontsize: 14,
                                  ),
                                  title: Text(
                                      getName(snapshot.data['members'][index])),
                                  trailing: const SizedBox(
                                    width: 50,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration:
                                          InputDecoration(prefix: Text("₹")),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                        return const Center(
                          child: Text("Lsa"),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Center(
                            child: CircularProgressIndicator(
                                backgroundColor: primaryColor),
                          ),
                        );
                      }
                    },
                  )),
              actions: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    child: const Text(
                      "Complete",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ));
  }
}
