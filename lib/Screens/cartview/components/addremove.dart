import 'package:flutter/material.dart';

class AddRemoveItem extends StatefulWidget {
  @override
  _AddRemoveItemState createState() => _AddRemoveItemState();
}

class _AddRemoveItemState extends State<AddRemoveItem> {
  int _item = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            print('removed');
            (_item > 1)
                ? setState(() {
                    _item -= 1;
                  })
                : setState(() {
                    _item = 1;
                  });
          },
        ),
        Text(_item.toString()),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _item += 1;
              });
            })
      ],
    );
  }
}
