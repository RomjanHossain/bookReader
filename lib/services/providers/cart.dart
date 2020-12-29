import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart. Stores the ids of each item.
  final List<int> _itemIds = [];

  /// The current catalog. Used to construct items from numeric ids.

  /// List of items in the cart.
  // List<BookModel> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  /// The current total price of all items.
  // int get totalPrice =>
  //     items.fold(0, (total, current) => total + current.price);

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(BookModel item) {
    // _itemIds.add(item);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(BookModel item) {
    // _itemIds.remove(item.id);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }
}

class BookModel {
  BookModel(
      {@required this.name, @required this.price, @required this.numofItem});
  final String name;
  final int price;
  final numofItem;
}
