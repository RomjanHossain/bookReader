import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DateTime timeCreated = DateTime.now();
  int nums;

  Future<User> getUser() async {
    return _auth.currentUser;
  }

  Stream<User> get user => _auth.authStateChanges();

  // google login
  Future<User> googleSignIn() async {
    try {
      // Trigger the authentication flow
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      createUserData(userCredential.user);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<void> createUserData(User user) {
    // nums = nums + 1;
    DocumentReference reportRef = _db.collection('reports').doc(user.uid);
    return reportRef.set(
      {
        'uid': user.uid,
        'isAdmin': false,
        'userEmail': user.email,
        'User Name': user.displayName,
        'user Photo': user.photoURL,
        'user Number': user.phoneNumber,
        'created': timeCreated,
        'lastActive': DateTime.now(),
      },
    );
  }

  Future<String> getProfilePic() async {
    return _auth.currentUser.photoURL;
  }

  //? facebook sign in!
  Future<User> signInWithFacebook() async {
    // Trigger the sign-in flow
    final result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    UserCredential usercredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    createUserData(usercredential.user);
    return usercredential.user;
  }

  //! signout
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Future<void> logOut() async {
    return await FacebookAuth.instance.logOut();
  }
}
