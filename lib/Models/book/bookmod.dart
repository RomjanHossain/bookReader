import 'package:flutter/foundation.dart';

class BookModel {
  BookModel(
      {@required this.name,
      @required this.price,
      @required this.numofItem,
      @required this.bookid});
  final String name, bookid;
  final int price, numofItem;
}
