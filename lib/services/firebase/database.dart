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
  Future<void> initBook(String bookid, String name, String des,
      List<String> cat, String file) async {
    await allbook(bookid, name, des, cat, file);
    await views(bookid);
    await catagory(bookid, cat, name);
    return true;
  }

  Future<void> allbook(String bookid, String name, String des, List<String> cat,
      String file) async {
    DocumentReference _allbook = _db.collection('All Book').doc(bookid);
    return _allbook.set(
      {
        'name': name,
        'author': 'none',
        'description': des,
        'Categorys': cat,
        'Download URL': file,
        'buy': false,
        "views": [
          0,
          0,
          0,
          0,
          0,
        ],
        'readed': 0,
        'upload Date': timeCreated,
        'rating': 0.0,
      },
    );
  }

  Future<void> views(String bookid) async {
    DocumentReference _views = _db.collection('Views').doc(bookid);
    return _views.set({
      'today': 0,
      'week': 0,
      'month': 0,
      'year': 0,
    });
  }

  Future<void> catagory(
    String bookid,
    List<String> cat,
    String name,
  ) async {
    cat.forEach((element) {
      DocumentReference _cat = _db.collection('Tags').doc(element);
      return _cat.update({
        bookid: name,
      });
    });
  }
}
