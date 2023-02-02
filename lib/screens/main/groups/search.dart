import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:payzero/component/color.dart';
import 'package:payzero/component/input/textfeid.dart';
import 'package:payzero/controllers/auth.dart';
import 'package:payzero/controllers/database.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool haveUserSearched = false;
  bool isJoined = false;

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

  initateSearch() async {
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await Datamethod()
          .searchGroupByName(_textEditingController.text)
          .then((snapshot) {
        setState(() {
          searchSnapshot = snapshot;
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: textColor,
        title: Text(
          "Search",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            TextInput(
              placeholder: "Search for group",
              autoFocus: true,
              textEditingController: _textEditingController,
              onsubmit: initateSearch,
            ),
            isLoading
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    ))
                : Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: searchList(),
                  )
          ],
        ),
      ),
    );
  }

  Widget searchList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: groupTile(
                    getName(searchSnapshot!.docs[index]['admin']),
                    searchSnapshot!.docs[index]['groupName'],
                    searchSnapshot!.docs[index]['groupId']),
              );
            },
          )
        : Container();
  }

  checkJoined(String groupName, String groupId) async {
    await Datamethod()
        .isUserJoined(Auth().currerntuser!.uid, groupId, groupName)
        .then((value) => {
              setState(() {
                isJoined = value;
              })
            });
  }

  Widget groupTile(String admin, String groupName, String groupId) {
    checkJoined(groupName, groupId);
    return ListTile(
      leading: ProfilePicture(name: groupName, radius: 24, fontsize: 14),
      title: Text(
        groupName,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Text(admin),
      trailing: isJoined
          ? const Icon(Icons.done_all)
          : TextButton(
              onPressed: () async {
                bool k = await Datamethod().groupJoin(
                    groupId,
                    groupName,
                    Auth().currerntuser!.uid,
                    Auth().currerntuser!.displayName!);
                if (k) {
                  showSnackbar(const Color.fromRGBO(57, 255, 20, 1),
                      "Group Joined Successfully");
                } else {
                  showSnackbar(const Color.fromARGB(255, 244, 120, 54),
                      "Error in joining the group");
                }
              },
              style: TextButton.styleFrom(
                  elevation: 0, surfaceTintColor: primaryColor),
              child: Text(
                "Join now",
                style: TextStyle(color: textColor),
              ),
            ),
    );
  }
  //   return Container(
  //     child: Text(username),
  //   );
  // }
}

/*
Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ProfilePicture(
                              name: searchSnapshot!.docs[index]['groupName'],
                              radius: 25,
                              fontsize: 14),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            searchSnapshot!.docs[index]['groupName'],
                            style: TextStyle(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Join",
                            style: TextStyle(color: textColor, fontSize: 16),
                          ))
                    ])
*/
