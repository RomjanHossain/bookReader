import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  MyBtn({@required this.onp, @required this.title, this.isActive = false});
  final String title;
  final Function onp;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: isActive
                  ? Colors.blue.withOpacity(0.5)
                  : Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        child: RawMaterialButton(
          onPressed: onp,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(title),
        ),
      ),
    );
  }
}

class KSmallBtn extends StatelessWidget {
  KSmallBtn({@required this.iconData, @required this.text});
  final IconData iconData;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 15,
            offset: Offset(2, 2), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      child: MaterialButton(
        onPressed: () {
          print('clicked');
        },
        child: Row(
          children: [
            Icon(iconData),
            Text(text),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 25),
      ),
    );
  }
}
