import 'package:flutter/material.dart';
import 'package:knowyourbook/Screens/cartview/cartView.dart';
import 'package:knowyourbook/services/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItemCount extends StatefulWidget {
  @override
  _CartItemCountState createState() => _CartItemCountState();
}

class _CartItemCountState extends State<CartItemCount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 30.0,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(cartRoute());
        },
        child: Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: null,
            ),
            Provider.of<CartModel>(context).totalBook == 0
                ? Container()
                : Positioned(
                    child: Stack(
                      children: <Widget>[
                        Icon(
                          Icons.brightness_1,
                          size: 20.0,
                          color: Colors.green[800],
                        ),
                        Positioned(
                          top: 3.0,
                          right: 4.0,
                          child: Center(
                            child: Text(
                              Provider.of<CartModel>(context)
                                  .totalBook
                                  .toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
