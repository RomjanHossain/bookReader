import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:async';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final DateTime timeCreated = DateTime.now();
  int nums;

  //! all book releated database is here!
  Future<void> allbook(String bookid, User user, String name, String des,
      List<String> cat, String file) async {
    DocumentReference _allbook = _db.collection('All Book').doc(bookid);
    return _allbook.set(
      {
        'name': name,
        'description': des,
        'Categorys': cat,
        'Download URL': file,
        "views": 0,
        'readed': 0,
        'upload Date': timeCreated,
        'rating': 0.0,
      },
    );
  }
}
