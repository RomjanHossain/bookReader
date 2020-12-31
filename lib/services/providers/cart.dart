import 'package:flutter/foundation.dart';
import 'package:knowyourbook/Models/book/bookmod.dart';

class CartModel extends ChangeNotifier {
  final List<BookModel> cartList = [];

  void removeAllBookfromList() {
    cartList.clear();
    totalBook = 0;
    notifyListeners();
  }

  List<String> get booknamelists {
    List<String> _bn = [];
    cartList.forEach((element) {
      _bn.add(element.name);
    });
    notifyListeners();
    return _bn;
  }

  List<String> get bookidlists {
    List<String> _bn = [];
    cartList.forEach((element) {
      _bn.add(element.bookid);
    });
    notifyListeners();
    return _bn;
  }

  bool isGift = false;
  int totalBook = 0;
  int get totalBookPrice {
    int _pp = 0;
    cartList.forEach(
      (element) {
        _pp += element.price;
      },
    );
    // notifyListeners();
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
