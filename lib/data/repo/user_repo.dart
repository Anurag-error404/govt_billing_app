import 'dart:io';

// import 'package:anime_track/models/watchlist_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../models/anime_model.dart';
// import '../../models/animetile_model.dart';
import '../../models/user_model.dart';

class UserRepo {
  final _firestore = FirebaseFirestore.instance;
  // UserModel _user = UserModel(uid: "", name: "", email: "", photoURL: "");
  bool isLoading = false;

  Future<UserModel> updateUserName(String fetchedUid, String name) async {
    try {
      isLoading = true;
      await _firestore
          .collection('users')
          .doc(fetchedUid)
          .update({'name': name});

      var value = await _firestore.collection('users').doc(fetchedUid).get();
      UserModel _user = UserModel.fromJson(value.data());
      isLoading = false;
      return _user;
    } catch (e) {
      rethrow;
    }
  }

  // Future<UserModel> updateUserPhoto(String fetchedUid, UserModel user) async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       // maxHeight: 512,
  //       // maxWidth: 512,
  //       // imageQuality: 90,
  //     );
  //     Reference ref = FirebaseStorage.instance
  //         .ref()
  //         .child("/profile_images/$fetchedUid/$fetchedUid.png");

  //     if (image != null) {
  //       await ref.putFile(File(image.path)).then((_) => true).catchError((_) => false)
  //           .then((_) => true)
  //           .catchError((_) => false);

  //       String newPhotoUrl = "";
  //       newPhotoUrl = await ref.getDownloadURL();

  //       await _firestore
  //           .collection('users')
  //           .doc(fetchedUid)
  //           .update({'photoUrl': newPhotoUrl});
  //       var value = await _firestore.collection('users').doc(fetchedUid).get();
  //       UserModel _user = UserModel.fromJson(value.data());
  //       isLoading = false;
  //       return _user;
  //     } else {
  //       var value = await _firestore.collection('users').doc(fetchedUid).get();
  //       UserModel _user = UserModel.fromJson(value.data());
  //       isLoading = false;
  //       return _user;
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<UserModel> resetUserPhoto(String fetchedUid, User user) async {
  //   try {
  //     var docRef = _firestore.collection("users").doc(fetchedUid);
  //     await docRef.update({"photoUrl": user.photoURL});

  //     var value = await _firestore.collection('users').doc(fetchedUid).get();
  //     UserModel _user = UserModel.fromJson(value.data());
  //     return _user;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<UserModel> createUser(User user) async {
    try {
      var collectionRef = _firestore.collection('users');
      var doc = await collectionRef.doc(user.uid).get();

      if (doc.exists == false) {
        await collectionRef.doc(user.uid).set({
          "name": user.displayName![0].toUpperCase() +
              user.displayName!.substring(1).toLowerCase(),
          "uid": user.uid,
          "email": user.email,
          "photoUrl": user.photoURL
        });

        var value = await collectionRef.doc(user.uid).get();
        UserModel _user = UserModel.fromJson(value.data());

        return _user;
      } else {
        // var value = await collectionRef.doc(user.uid).get();
        var value = await _firestore.collection('users').doc(user.uid).get();
        UserModel _user = UserModel.fromJson(value.data());

        return _user;
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
                  await _firestore
                      .collection('invoices')
                      .doc('$fetchedUid')
                      .set({"Invoices": {}})
                }
            },
          )
          .catchError((error) => {print("Error getting document:" + error)});
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> createFavourites(String fetchedUid) async {
  //   try {
  //     var docRef = _firestore.collection("favourites").doc(fetchedUid);
  //     docRef
  //         .get()
  //         .then(
  //           (doc) async => {
  //             if (!doc.exists)
  //               {
  //                 print('not exist'),
  //                 await _firestore
  //                     .collection('favourites')
  //                     .doc('$fetchedUid')
  //                     .set({"Anime": {}})
  //               }
  //           },
  //         )
  //         .catchError((error) => {print("Error getting document:" + error)});
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> addToFavourites(Anime anime, String fetchedUid) async {
  //   try {
  //     var docRef = _firestore.collection("favourites").doc(fetchedUid);
  //     await docRef.update({
  //       "Anime.${anime.malId}": {
  //         "malId": anime.malId,
  //         "title": anime.title,
  //         "titleEng": anime.titleEnglish != "" && anime.titleEnglish != "TBA"
  //             ? anime.titleEnglish
  //             : anime.title,
  //         "imageUrl": anime.imageUrl,
  //         "season": anime.season,
  //         "year": int.parse(anime.airingDate.substring(0,4))
  //       }
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> addToWatchlist(
  //     WatchlistTile anime, String fetchedUid, String type) async {
  //   try {
  //     var docRef = _firestore.collection("watchlist").doc(fetchedUid);
  //     await docRef.update({
  //       "Anime.${anime.malId}": {
  //         "malId": anime.malId,
  //         "title": anime.title,
  //         "titleEng": anime.titleEnglish,
  //         "imageUrl": anime.imageUrl,
  //         "season": anime.season,
  //         "year": anime.year,
  //         "watch_status": type,
  //         "air_status": anime.airStatus,
  //       }
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> removeFromFavourites(int malId, String fetchedUid) async {
  //   try {
  //     var docRef = _firestore.collection("favourites").doc(fetchedUid);
  //     await docRef.update({"Anime.$malId": FieldValue.delete()});
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> removeFromWatchlist(int malId, String fetchedUid) async {
  //   try {
  //     var docRef = _firestore.collection("watchlist").doc(fetchedUid);
  //     await docRef.update({"Anime.$malId": FieldValue.delete()});
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
