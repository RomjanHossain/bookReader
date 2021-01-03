import 'package:flutter/foundation.dart';

class BookModel {
  BookModel({
    @required this.name,
    @required this.price,
    @required this.numofItem,
    @required this.bookid,
    @required this.cover,
  });
  final String name, bookid, cover;
  final int price, numofItem;
}
