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
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          /*
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                MyBtn(
                  title: 'Books',
                  onp: () {},
                  isActive: true,
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
          */
          Expanded(
            child: TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              tabs: [
                MyBtn(
                  title: 'New Books',
                  onp: null,
                  isActive: true,
                ),
                MyBtn(
                  title: 'Most Populer',
                  onp: null,
                  isActive: false,
                ),
                MyBtn(
                  title: 'Tranding',
                  onp: null,
                ),
                MyBtn(
                  title: 'Requested',
                  onp: null,
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
