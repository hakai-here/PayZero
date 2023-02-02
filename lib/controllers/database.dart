import 'package:cloud_firestore/cloud_firestore.dart';

class Datamethod {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  Future<bool> _ifuserData(String uid) async {
    try {
      var doc = await userCollection.doc(uid).get();

      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  Future<bool> initilizeuserData(String uid) async {
    try {
      if (!await _ifuserData(uid)) {
        await userCollection.doc(uid).set({'group': []});
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future getUsergroups(String uid) async {
    return userCollection.doc(uid).snapshots();
  }

  Future createGroup(String username, String uid, String groupName) async {
    DocumentReference documentReference = await groupCollection.add({
      "groupName": groupName,
      "admin": "${uid}_$username",
      "members": [],
      "groupId": ""
    });

    await documentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$username"]),
      "groupId": documentReference.id
    });

    DocumentReference userDocument = userCollection.doc(uid);
    await userDocument.update({
      'group': FieldValue.arrayUnion(["${documentReference.id}_$groupName"])
    });
  }

  Future<bool> deleteGroup(
      String uid, String username, String groupId, String groupName) async {
    DocumentReference userDocument = userCollection.doc(uid);
    DocumentReference groupDocument = groupCollection.doc(groupId);
    try {
      await userDocument.update({
        'group': FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocument.update({
        "members": FieldValue.arrayRemove(["${uid}_$username"])
      });
    } catch (e) {
      return false;
    }
    return true;
  }

  Future getTrans(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("transations")
        .orderBy("time")
        .snapshots();
  }

  Future getMembers(String groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  Future searchGroupByName(String groupName) {
    return groupCollection.where('groupName', isEqualTo: groupName).get();
  }

  Future<bool> isUserJoined(
      String uid, String groupId, String groupName) async {
    DocumentReference userReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userReference.get();
    List<dynamic> group = await documentSnapshot['group'];
    if (group.contains("${groupId}_$groupName")) {
      return true;
    }
    return false;
  }

  Future<bool> groupJoin(
      String groupId, String groupName, String userID, String userName) async {
    try {
      DocumentReference userDoc = userCollection.doc(userID);
      DocumentReference groupDoc = groupCollection.doc(groupId);

      DocumentSnapshot userDocSnapshot = await userDoc.get();
      List<dynamic> group = await userDocSnapshot['group'];
      if (!group.contains("${groupId}_$groupName")) {
        await userDoc.update({
          'group': FieldValue.arrayUnion(["${groupId}_$groupName"])
        });
        await groupDoc.update({
          "members": FieldValue.arrayUnion(["${userID}_$userName"])
        });
      }
    } catch (e) {
      return false;
    }
    return true;
  }
}
