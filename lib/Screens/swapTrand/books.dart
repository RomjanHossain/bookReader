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
  int _number = 0;
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
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Expanded(
            child: TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              // indicatorSize: TabBarIndicatorSize.label,
              onTap: (int lol) {
                setState(() {
                  _number = lol;
                });
              },
              tabs: [
                MyBtn(
                  title: 'New Books',
                  swapActive: _number == 0 ? true : false,
                ),
                MyBtn(
                  title: 'Most Populer',
                  swapActive: _number == 1 ? true : false,
                ),
                MyBtn(
                  title: 'Tranding',
                  swapActive: _number == 2 ? true : false,
                ),
                MyBtn(
                  title: 'Requested',
                  swapActive: _number == 3 ? true : false,
                ),
              ],
            ),
          ),
          //end tabbar
          Expanded(
            flex: 8,
            child: TabBarView(
              children: [
                // new Books
                StaggeredGridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  children: books,
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  staggeredTiles: mystaggeredTiles,
                ),
                // most popular
                StaggeredGridView.count(
                  crossAxisCount: 3,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  children: books,
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  staggeredTiles: mystaggeredTiles,
                ),
                // Tranding
                StaggeredGridView.count(
                  crossAxisCount: 4,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  children: books,
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  staggeredTiles: mystaggeredTiles,
                ),
                // requested
                StaggeredGridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  children: books,
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  staggeredTiles: mystaggeredTiles,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
