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

  Future<bool> deleteGroup(String uid, String group) async {
    DocumentReference userDocument = userCollection.doc(uid);
    try {
      await userDocument.update({
        'group': FieldValue.arrayRemove([group])
      });
    } catch (e) {
      return false;
    }
    return true;
  }
}
