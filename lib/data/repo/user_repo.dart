import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserRepo {
  final _firestore = FirebaseFirestore.instance;
  // UserModel _user = UserModel(uid: "", name: "", email: "", photoURL: "");
  bool isLoading = false;

  Future<UserModel> updateUserName(String fetchedUid, String name) async {
    try {
      isLoading = true;
      await _firestore.collection('users').doc(fetchedUid).update({'name': name});

      var value = await _firestore.collection('users').doc(fetchedUid).get();
      UserModel user = UserModel.fromJson(value.data());
      isLoading = false;
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> createUser(User user) async {
    try {
      var collectionRef = _firestore.collection('users');
      var doc = await collectionRef.doc(user.uid).get();

      if (doc.exists == false) {
        await collectionRef.doc(user.uid).set({
          "name": user.displayName![0].toUpperCase() + user.displayName!.substring(1).toLowerCase(),
          "uid": user.uid,
          "email": user.email,
          "photoUrl": user.photoURL
        });

        var value = await collectionRef.doc(user.uid).get();
        UserModel userData = UserModel.fromJson(value.data());

        return userData;
      } else {
        // var value = await collectionRef.doc(user.uid).get();
        var value = await _firestore.collection('users').doc(user.uid).get();
        UserModel userData = UserModel.fromJson(value.data());

        return userData;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createInvoiceDoc(String fetchedUid) async {
    try {
      var docRef = _firestore.collection("invoices").doc(fetchedUid);
      docRef
          .get()
          .then(
            (doc) async => {
              if (!doc.exists)
                {
                  print('not exist'),
                  await _firestore.collection('invoices').doc(fetchedUid).set({"Invoices": {}})
                }
            },
          )
          .catchError((error) => {print("Error getting document:" + error)});
    } catch (e) {
      rethrow;
    }
  }
}
