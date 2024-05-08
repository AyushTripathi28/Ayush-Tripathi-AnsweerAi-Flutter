import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String capitalize(String str) {
  if (str.isEmpty) {
    return str;
  }
  return str[0].toUpperCase() + str.substring(1).toLowerCase();
}

class AuthService {
  //instace of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //save user data to firestore
      _firestore.collection('Users').doc(userCredential.user!.uid).update({
        "uid": userCredential.user!.uid,
        "email": email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("SIGNINERROR");
      print(e.toString());
      throw Exception(e.code);
    }
  }

  //sign up with email and password
  Future signUpWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(name);
      Timestamp userCreationTime = Timestamp.now();

      //save user data to firestore
      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
        "name": capitalize(name),
        "threads": [],
        "userCreatedTime": userCreationTime,
        "lastLoginTime": userCreationTime,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("SIGNUPERROR");
      print(e.toString());
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return;
    }
  }
}
