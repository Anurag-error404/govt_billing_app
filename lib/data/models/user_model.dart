import 'package:flutter/material.dart';

class UserModel {
  String name = "";
  String uid = "";
  String email = "";
  final String photoURL;

  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      this.photoURL = ""});

  factory UserModel.empty() {
    return UserModel(uid: '', name: '', email: '', photoURL: '');
  }
  factory UserModel.fromJson(Map<String, dynamic>? data) {
    return UserModel(
        uid: data!['uid'] ?? '',
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        photoURL: data['photoUrl'] ?? '');
  }

  UserModel copyWith(
      {required String name,
      required String uid,
      required String email,
      required String photoURL}) {
    return UserModel(email: email, name: name, uid: uid, photoURL: photoURL);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'photoURL': photoURL,
    };
  }
}
