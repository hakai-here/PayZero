import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:payzero/component/alert/create_galert.dart';
import 'package:payzero/component/color.dart';
import 'package:payzero/controllers/auth.dart';
import 'package:payzero/controllers/database.dart';
import 'package:payzero/screens/main/groups/group_page.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  Stream? _groupstream;
  final TextEditingController _editingController = TextEditingController();
  bool displaygroup = false;
  int indexn = 0;
  String gname = "";
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

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  void showSnackbar(Color color, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      backgroundColor: color,
    ));
  }

  void deleteGroup(String groupid) async {
    bool k = await Datamethod().deleteGroup(Auth().currerntuser!.uid, groupid);
    if (k) {
      // ignore: use_build_context_synchronously
      showSnackbar(const Color.fromARGB(255, 244, 120, 54),
          "Group Deleted Successfully");
    }
  }

  void createGroup() async {
    String groupname = _editingController.text;
    try {
      if (groupname != "") {
        await Datamethod().createGroup(Auth().currerntuser!.displayName!,
            Auth().currerntuser!.uid, groupname);
        showSnackbar(
            const Color.fromRGBO(57, 255, 20, 1), "Group created Successfully");
      }
    } catch (e) {
      showSnackbar(const Color.fromARGB(255, 244, 120, 54), e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: displaygroup
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  IconButton(
                      onPressed: () => setState(() {
                            displaygroup = false;
                          }),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xff686777),
                      )),
                  ProfilePicture(
                    name: gname,
                    radius: 20,
                    fontsize: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    gname,
                    style: TextStyle(color: textColor),
                  )
                ],
              ),
            )
          : AppBar(
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
      body: displaygroup ? grouPage() : groupList(),
      floatingActionButton: displaygroup
          ? null
          : FloatingActionButton(
              onPressed: () => popUpAlert(
                  context,
                  "Create a group",
                  "Group name",
                  "Create group",
                  _editingController,
                  createGroup),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(
                    itemCount: snapshot.data['group'].length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            gname = getName(snapshot.data['group'][index]);
                            displaygroup = true;
                          });
                        },
                        child: Ink(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ProfilePicture(
                                      name: getName(
                                          snapshot.data['group'][index]),
                                      radius: 25,
                                      fontsize: 18,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      getName(snapshot.data['group'][index]),
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    splashRadius: 19,
                                    onPressed: () => deleteGroup(
                                        snapshot.data['group'][index]),
                                    icon: const Icon(
                                      Icons.exit_to_app,
                                      color: Colors.redAccent,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
