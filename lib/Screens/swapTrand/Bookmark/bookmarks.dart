import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class BookMarks extends StatefulWidget {
  @override
  _BookMarksState createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  String dropdownValue = 'name';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (Provider.of<User>(context) != null)
          ? StaggeredGridView.countBuilder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://i.pinimg.com/originals/62/04/3b/62043b0bb353f49600a23ed1b5ec922f.jpg',
                      ),
                    ),
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8, top: 5),
                      child: Icon(
                        CupertinoIcons.bookmark,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
              itemCount: 12,
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, index.isEven ? 1.5 : 1.7);
              },
              crossAxisCount: 3,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              scrollDirection: Axis.vertical,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            )
          : Center(
              child: Text('No bookmark found'),
            ),
    );
    // ],
    // );
  }
}
