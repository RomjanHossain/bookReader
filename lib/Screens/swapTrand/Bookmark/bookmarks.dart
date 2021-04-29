import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:provider/provider.dart';

class BookMarks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context);
    return Container(
      child: (_user != null)
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Bookmarks')
                  .doc(_user.uid)
                  .get(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? StaggeredGridView.countBuilder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Text(
                              '${snapshot.data}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                          );
                        },
                        itemCount: 3,
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(
                              1, index.isEven ? 1.5 : 1.7);
                        },
                        crossAxisCount: 3,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                        scrollDirection: Axis.vertical,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      )
                    : kloading();
              })
          : Center(
              child: Text('No bookmark found'),
            ),
    );
    // ],
    // );
  }
}
