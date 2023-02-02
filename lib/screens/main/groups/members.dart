import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:payzero/component/color.dart';
import 'package:payzero/controllers/database.dart';

class Members extends StatefulWidget {
  final String groupname;
  final String groupId;
  const Members({super.key, required this.groupId, required this.groupname});

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  Stream? stream;

  @override
  void initState() {
    getMembers();
    super.initState();
  }

  getMembers() async {
    await Datamethod().getMembers(widget.groupId).then((value) {
      setState(() {
        stream = value;
      });
    });
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                        name: getName(snapshot.data['members'][index]),
                        radius: 24,
                        fontsize: 19,
                      ),
                      title: Text(
                        getName(snapshot.data['members'][index]),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(getId(snapshot.data['members'][index])),
                    );
                  },
                );
              }
            }
            return const Center(
              child: Text("Some error occured"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
        },
      ),
    );
  }
}
