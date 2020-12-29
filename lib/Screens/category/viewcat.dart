import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

Route createRoute(QueryDocumentSnapshot val) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ViewCat(
      vals: val,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

class ViewCat extends StatelessWidget {
  ViewCat({this.vals});
  final QueryDocumentSnapshot vals;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'category',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              LineIcons.times,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        children: [
          Text(vals.data().toString()),
          // vals.data().forEach((key, value) {return Text()})
        ],
      ),
    );
  }
}
