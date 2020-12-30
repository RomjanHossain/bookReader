import 'package:flutter/foundation.dart';

class BookModel {
  BookModel(
      {@required this.name, @required this.price, @required this.numofItem});
  final String name;
  final int price;
  final int numofItem;
}
