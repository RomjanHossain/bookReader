import 'package:flutter/material.dart';
import 'package:knowyourbook/Models/book/bookmod.dart';
import 'package:knowyourbook/services/providers/cart.dart';
import 'package:provider/provider.dart';

class ProductStack extends StatelessWidget {
  ProductStack({this.price, this.title, this.model});
  final String title;
  final int price;
  final BookModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                offset: Offset(-4, 4),
                blurRadius: 5,
                // spreadRadius: 3,
              ),
              // BoxShadow(
              //   color: Colors.black.withOpacity(.2),
              //   offset: Offset(2, -2),
              //   blurRadius: 5,
              //   // spreadRadius: 3,
              // ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'images/pro.jpg',
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '৳$price',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    // AddRemoveItem(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          child: GestureDetector(
            onTap: () {
              Provider.of<CartModel>(context, listen: false).remove(model);
            },
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(0xFFc5bcd1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
