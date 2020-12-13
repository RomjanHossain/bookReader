import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BookMarks extends StatefulWidget {
  @override
  _BookMarksState createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  String dropdownValue = 'name';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: Offset(-4, 4), // changes position of shadow
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['name', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: StaggeredGridView.countBuilder(
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
          ),
        ),
      ],
    );
  }
}
