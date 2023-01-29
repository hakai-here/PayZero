import 'package:cloud_firestore/cloud_firestore.dart';

class Datamethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> _ifuserData(String uid) async {
    try {
      var doc = await _firestore.collection('users').doc(uid).get();

      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  Future<bool> initilizeuserData(String uid) async {
    try {
      if (!await _ifuserData(uid)) {
        await _firestore.collection('users').doc(uid).set({'group': []});
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future getUsergroups(String uid) async {
    return _firestore.collection('users').doc(uid).snapshots();
  }
}
