import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/Classes/user.dart';

class userInteract {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  Future<Map<String, dynamic>?> getUserConnected() async {
    Map<String, dynamic>? userData;
    final userID = FirebaseAuth.instance.currentUser!.uid;
    await users.doc(userID).get().then((value) {
      if (value.data()!.isEmpty) return null;
      userData = value.data();
    });
    return userData;
  }

  Future<List<Map<String, dynamic>?>> getFavoritePictures() async {
    List<Map<String, dynamic>?> pictures = [];
    final userID = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference pictureRef =
        FirebaseFirestore.instance.collection("Pictures");

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userID)
        .get()
        .then((user) async {
      for (final pictureID in user.data()!['favorites']) {
        final picture = await pictureRef.doc(pictureID).get();
        if (picture.data() != null) pictures.add(picture.data());
      }
    });
    return pictures;
  }

  Future<List<Map<String, dynamic>?>> getHomepagePictures() async {
    CollectionReference picturesCollection =
        FirebaseFirestore.instance.collection("Pictures");
    final List<Map<String, dynamic>?> pictures = [];

    await picturesCollection
        .orderBy('date', descending: true)
        .get()
        .then((documents) async {
      for (QueryDocumentSnapshot picDoc in documents.docs) {
        final List<Map<String, dynamic>?> comments = [];
        final pictureTMP = picDoc.data();
        await picturesCollection
            .doc(picDoc.id)
            .collection('Comments')
            .orderBy('date', descending: true)
            .get()
            .then((docs) {
          for (QueryDocumentSnapshot comDoc in docs.docs) {
            comments.add(comDoc.data());
          }
          if (docs.docs.isNotEmpty) pictureTMP!['comments'] = comments;
          pictureTMP!['id'] = picDoc.id;
          if (documents.docs.isNotEmpty) pictures.add(pictureTMP);
        });
      }
    });
    return pictures;
  }

  Future<List<Map<String, dynamic>?>> getUserBySearch(String keyWord) async {
    List<Map<String, dynamic>?> userData = [];
    await users.where('caseSearch', arrayContains: keyWord).get().then((value) {
      if (value.docs.isEmpty) return null;
      for (final user in value.docs) {
        final userTMP = user.data();
        userTMP!['id'] = user.id;
        debugPrint(userTMP['id']);
        userData.add(userTMP);
      }
    });
    return (userData);
  }
}
