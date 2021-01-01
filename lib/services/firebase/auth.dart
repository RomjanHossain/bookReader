import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

      accountCounts(userCredential.user);
      createUserData(userCredential.user);
      return userCredential.user;
    } catch (e) {
      print('error from Google Sign in method:\n$e');
      return null;
    }
  }

// setted first user values
  Future<void> createUserData(User user) {
    DocumentReference userRef = _db.collection('Users').doc(user.uid);

    return userRef.set(
      {
        'uid': user.uid,
        'isAdmin': false,
        'userEmail': user.email,
        'User Name': user.displayName,
        'user Photo': user.photoURL,
      },
    );
  }

  //? account counts
  Future<void> accountCounts(User user) async {
    DocumentReference _ac = _db.collection('Account Count').doc('total');
    var _acU = await _ac.get().then((value) => value.data().values.first);

    Future<int> value = _db.collection('Account Count').snapshots().length;
    if (await value != null) {
      _ac.update({'total': value});
      print('this is _acU\n $value');
    }

    DocumentReference accountRef =
        _db.collection('Account Count').doc(user.uid);
    print('this is _acU\n $_acU');
    return accountRef.set(
      {
        'uid': user.uid,
        'userEmail': user.email,
        'User Name': user.displayName,
        'account number': _acU,
        'created': timeCreated,
        'lastActive': DateTime.now(),
      },
    );
  }

  //! All the user collections are here
  Future<void> userReaded(String bookid, User user) async {
    return _db
        .collection('Users')
        .doc(user.uid)
        .collection('Readed')
        .doc(bookid);
    // return _db.doc('Users').collection('Readed').doc(bookid);
  }

  Future<void> userViewd(String bookid, User user) async {
    _db.collection('Users').doc(user.uid).collection('Viewed').doc(bookid);
  }

  Future<void> userUploaded(String bookid, User user) async {
    DocumentReference _dd = _db
        .collection('Users')
        .doc(user.uid)
        .collection('Uploaded')
        .doc(bookid);
    return _dd.set({
      'bookid': bookid,
    });
  }

  Future<void> userBookmarked(String bookid, User user) async {
    _db.collection('Users').doc(user.uid).collection('Bookmarked').doc(bookid);
  }

  //! signout
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
