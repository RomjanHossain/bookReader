import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  MyBtn({@required this.onp, @required this.title});
  final String title;
  final Function onp;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        width: 200,
        child: MaterialButton(
          onPressed: onp,
          // color: Colors.white,
          child: Text(title),
        ),
      ),
    );
  }
}
