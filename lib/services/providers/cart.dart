import 'package:flutter/foundation.dart';
import 'package:knowyourbook/Models/book/bookmod.dart';

class CartModel extends ChangeNotifier {
  final List<BookModel> cartList = [];
  int totalBook = 0;
  int get totalBookPrice {
    int _pp = 0;
    cartList.forEach((element) {
      _pp += element.price;
    });
    return _pp;
  }

  void add(BookModel item) {
    cartList.add(item);
    totalBook += 1;
    notifyListeners();
  }

  void remove(BookModel item) {
    cartList.remove(item);
    totalBook -= 1;
    notifyListeners();
  }
}
