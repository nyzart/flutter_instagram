import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> logIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (err) {
      return err.message;
    }
  }

  Future<String?> signUp(String name, String username, String email,
      String password, String biography) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    QuerySnapshot usernameCheck =
        await users.where('username', isEqualTo: username).get();
    QuerySnapshot emailCheck =
        await users.where('email', isEqualTo: email).get();

    if (usernameCheck.docs.isNotEmpty) {
      return ("User with this username already exists.");
    }

    if (emailCheck.docs.isNotEmpty) {
      return ("User with this email already exists.");
    }

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userID = FirebaseAuth.instance.currentUser!.uid;
      List<String> caseSearch = [];
      String search = '';

      for (int i = 0; i < username.length; i++) {
        search += username[i];
        if (search.length > 1) caseSearch.add(search);
      }
      await users.doc(userID).set({
        'name': name,
        'username': username,
        'email': email,
        'biography': biography,
        'publicationsNumber': 0,
        'likedPostedPicturesNumber': 0,
        'likedPicturesNumber': 0,
        'caseSearch': caseSearch
      }).catchError((error) => print("Failed to add user $error"));
      return "Registered in";
    } on FirebaseAuthException catch (err) {
      return err.message;
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
