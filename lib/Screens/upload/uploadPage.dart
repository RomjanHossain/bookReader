import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/Screens/upload/uploadForm.dart';
import 'package:knowyourbook/values/const.dart';

//? animation for upload page
Route uploadPageAnimation(String uid) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        UpLoadPage(uid: uid),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, 1.0);
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

class UpLoadPage extends StatelessWidget {
  static const String id = 'upload';
  UpLoadPage({this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(uploadFormPageAnimation()),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Upload',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Users')
              .doc(uid)
              .collection('Uploaded')
              .get(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (_, i) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                '${snapshot.data.docs[i]["cover"]}',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${snapshot.data.docs[i]["name"]}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : kloading();
          }),
    );
  }
}
