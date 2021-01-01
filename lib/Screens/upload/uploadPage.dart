import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/Screens/upload/uploadForm.dart';
import 'package:knowyourbook/values/const.dart';

enum tags { harder, smarter, selfStarter, tradingCharter }

class UpLoadPage extends StatelessWidget {
  static const String id = 'upload';
  UpLoadPage({this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RealUpPage.id);
        },
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
                            height: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                                image: AssetImage('images/pro.jpg'),
                              ),
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${snapshot.data.docs[i]["bookid"]}',
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
