import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<StaggeredTile> mystaggeredTiles = [
    StaggeredTile.fit(1),
    StaggeredTile.fit(1),
    StaggeredTile.fit(1),
    StaggeredTile.fit(1),
    StaggeredTile.fit(1),
    StaggeredTile.fit(1),
  ];
  List<Widget> books = [
    Container(
      height: 250,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text('Mnly'),
      ),
    ),
    Container(
      height: 300,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text('holy'),
      ),
    ),
    Container(
      height: 250,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text('holy'),
      ),
    ),
    Container(
      height: 300,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text('holy'),
      ),
    ),
    Container(
      height: 250,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text('holy'),
      ),
    ),
    Container(
      height: 300,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text('holy'),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              MyBtn(
                title: 'Ebooks',
                onp: () {},
              ),
              MyBtn(
                title: 'Most Populer',
                onp: () {},
              ),
              MyBtn(
                title: 'New',
                onp: () {},
              ),
              MyBtn(
                title: 'Requested',
                onp: () {},
              ),
            ],
          ),
        ),
        Expanded(
          flex: 8,
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            children: books,
            scrollDirection: Axis.vertical,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            staggeredTiles: mystaggeredTiles,
          ),
        ),
      ],
    );
  }
}
