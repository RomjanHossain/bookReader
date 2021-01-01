import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:async';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final DateTime timeCreated = DateTime.now();
  int nums;

  //! all book releated database is here!
  Future<void> initBook(User user, String bookid, String name, String des,
      List<String> cat, String file) async {
    await allbook(user, bookid, name, des, cat, file);

    await catagory(bookid, cat, name);
    return true;
  }

  Future<void> allbook(User user, String bookid, String name, String des,
      List<String> cat, String file) async {
    DocumentReference _allbook = _db.collection('All Book').doc(bookid);
    return _allbook.set(
      {
        'name': name,
        'author': 'none',
        'description': des,
        'Categorys': cat,
        'Download URL': file,
        'buy': false,
        "views today": 0,
        "views week": 0,
        "views month": 0,
        "views year": 0,
        'views alltime': 0,
        'readed': 0,
        'upload Date': timeCreated,
        'rating': 0.0,
        'price': 0,
        'uploader': user.displayName,
      },
    );
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

  //! this is viewpoint for the lol
  // here goes all the book sort by date!! //? New Books

  //? readed value update if user clicked on read
  Future<void> updateReaded(String bookid) async {
    final DocumentReference docRef = _db.collection("All Book").doc(bookid);
    docRef.update({"readed": FieldValue.increment(1)});
  }

  /*
  * The math part here so don't screw with this code bitch!
  * i don't know wha to write
  * let's try
  */
  viewUpdate(String bookid) async {
    final DocumentReference _allBook = _db.collection("All Book").doc(bookid);
    /*
    var _now = DateTime.now();
    var _today = DateTime(_now.year, _now.month, _now.day);
    int _todayInTP = 0;
    int _tomInTP = 0;
    var _tomorrow = _today.add(Duration(days: 1));
    //? get todays date from firebase

    await _db.collection('Date').doc('today').get().then((value) {
      _todayInTP = value["date"].seconds;
      print(' the time \n${value["date"].seconds}');
    });
    await _db.collection('Date').doc('tomorrow').get().then((value) {
      _tomInTP = value["tom"].seconds;
      print(' the time \n${value["tom"].seconds}');
    });
    */
    //! update viewCount

    _allBook.update({
      'views today': FieldValue.increment(1),
      'views week': FieldValue.increment(1),
      'views month': FieldValue.increment(1),
      'views year': FieldValue.increment(1),
      'views alltime': FieldValue.increment(1),
    });
  }

  //? for the drawer
  Future<DocumentSnapshot> tagData(String tag) async {
    DocumentSnapshot _snaps = await _db.collection('Tags').doc(tag).get();
    return _snaps;
  }

//! place order
  Future<void> placeOrderAnon(
    List<String> bookid,
    String orderID,
    List<String> bookName,
    String address,
    String number,
    int price,
    bool isGift,
    String inDhaka,
  ) async {
    DocumentReference _order = _db.collection('Order').doc(orderID);
    return _order.set(
      {
        'book_name': bookName,
        'book_id': bookid,
        'user addresss': address,
        'user number': number,
        'total': price,
        'gift': isGift,
        'inDhaka': inDhaka,
        'completed': false,
        'order Data': DateTime.now(),
      },
    );
  }

  Future<void> placeOrderUser(
    User user,
    List<String> bookid,
    String orderID,
    List<String> bookName,
    String address,
    String number,
    int price,
    bool isGift,
    String inDhaka,
  ) async {
    DocumentReference _order = _db.collection('Order').doc(orderID);
    DocumentReference _userr = _db
        .collection('Users')
        .doc(user.uid)
        .collection('ordered')
        .doc(orderID);
    await _userr.set(
      {
        'book_name': bookName,
        'total': price,
        'gift': isGift,
        'in Dhaka': inDhaka,
        'completed': false,
        'order Data': DateTime.now(),
      },
    );
    await _order.set(
      {
        'book_name': bookName,
        'book_id': bookid,
        'user Name': user.displayName,
        'user addresss': address,
        'user number': number,
        'total': price,
        'gift': isGift,
        'completed': false,
        'user mail': user.email,
        'order Data': DateTime.now(),
      },
    );
    return true;
  }

  //? get length of orders
  Future<int> countOrder(User user) async {
    QuerySnapshot _myDoc =
        await _db.collection('Users').doc(user.uid).collection('ordered').get();
    return _myDoc.docs.length;
  }

  Future<int> uploadOrder(User user) async {
    QuerySnapshot _myDoc = await _db
        .collection('Users')
        .doc(user.uid)
        .collection('Uploaded')
        .get();
    return _myDoc.docs.length;
  }

  //? get book detail from doc
  Future<DocumentSnapshot> bookData(String bookid) async {
    return _db.collection('All Book').doc(bookid).get();
  }
}
