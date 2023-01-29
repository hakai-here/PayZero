import 'package:flutter/material.dart';
import 'package:payzero/component/alert/create_galert.dart';
import 'package:payzero/component/color.dart';
import 'package:payzero/controllers/auth.dart';
import 'package:payzero/controllers/database.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  Stream? _groupstream;
  final TextEditingController _editingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllData();
  }

  getAllData() async {
    await Datamethod().getUsergroups(Auth().currerntuser!.uid).then((snapshot) {
      setState(() {
        _groupstream = snapshot;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Icon(
            Icons.groups,
            color: textColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Groups",
            style: TextStyle(color: textColor),
          )
        ]),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => popUpAlert(context, "Create a group", "Group name",
            "Create group", _editingController, () {}),
        elevation: 0,
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  Widget groupList() {
    return StreamBuilder(
        stream: _groupstream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['group'] != null) {
              if (snapshot.data['group'].length != 0) {
                return const Text("hello");
              } else {
                return noGroupWidget();
              }
            } else {
              return noGroupWidget();
            }
          } else {
            return Center(
                child:
                    CircularProgressIndicator(backgroundColor: primaryColor));
          }
        });
  }

  Widget noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/group.png',
                height: 240,
              ),
              Text(
                "Currently you are not in any group , Find a group by searching or create your own with the add button.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
