import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_do/database/models/user_model.dart';
import 'package:flutter_do/utils/firestore_collections.dart';

//Firebase-Authentication-Functions
class FirebaseAuthFunctions {
  //Singleton-Object
  FirebaseAuthFunctions._internal();
  static FirebaseAuthFunctions instance = FirebaseAuthFunctions._internal();
  factory FirebaseAuthFunctions() => instance;

  //Register User to Firebase & Save Details in Firestore
  Future<dynamic> registerUserUsingEmail(
      String userName, String userEmail, String userPassword) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      //Current-User-Data
      User? user = userCredential.user;

      if (user != null) {
        //Updating-User-Profile
        await FirebaseAuth.instance.currentUser!.updateProfile(
          displayName: userName,
        );
        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        //Creating-User-Model
        UserModel newUser = UserModel(userName: userName, userId: user!.uid);

        //Storing-User-Details-In-Firebase;
        await FirebaseFirestore.instance
            .collection(userCollections)
            .doc(user.uid)
            .set(newUser.toMap());

        return newUser;
      } else {
        return FirebaseAuthException(
            code: "ERROR_REGISTERING_USER", message: "Error Registering User!");
      }
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  //Authenticate User with Firebase Using Email
  Future<dynamic> authenticateUserUsingEmail(
      String userEmail, String userPassword) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPassword);
      final currentUser = userCredential.user;
      if (currentUser != null) {
        return UserModel.fromMap(
            {"User Name": currentUser.displayName, "User Id": currentUser.uid});
      } else {
        return FirebaseAuthException(
            code: "ERROR_FETCHING_USER", message: "Error Registering User!");
      }
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
