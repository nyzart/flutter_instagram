import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as Path;

class PictureInteractions {
  CollectionReference pictures =
      FirebaseFirestore.instance.collection('Pictures');

  Future<void> addFavorite(String pictureID) async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('Users').doc(user).update({
      "favorites": FieldValue.arrayUnion([pictureID]),
      "likedPicturesNumber": FieldValue.increment(1)
    });
  }

  Future<void> addPicture(File picture, String uid) async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    final username =
        await FirebaseFirestore.instance.collection('Users').doc(user).get();
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(picture.path)}');
    await ref.putFile(picture).whenComplete(() async {
      await ref.getDownloadURL().then((value) async {
        pictures.add({
          'pictureLink': value,
          'userID': uid,
          'date': Timestamp.now(),
          'likes': 0,
          'username': username['username']
        }).then((docRef) async {
          await FirebaseFirestore.instance.collection('Users').doc(uid).update({
            "pictures": FieldValue.arrayUnion([docRef.id])
          });
        });
      });
    });
  }

  Future<List<Map<String, dynamic>?>> getUserPictures(String uid) async {
    List<Map<String, dynamic>?> pictures = [];

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get()
        .then((doc) async {
      dynamic data = doc.data();
      for (final pictureID in data!['pictures']) {
        await FirebaseFirestore.instance
            .collection('Pictures')
            .doc(pictureID)
            .get()
            .then((pictureDoc) {
          dynamic pictureData = pictureDoc.data();
          pictureData['id'] = pictureDoc.id;
          pictures.add(pictureData);
        });
      }
    });
    return pictures;
  }
}
