import 'package:flutter/material.dart';
import 'package:knowyourbook/Widgets/bottomNavBar.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Books',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: Icon(
          LineIcons.navicon,
          color: Colors.black,
          size: 30,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.search, color: Colors.black, size: 30),
          )
        ],
      ),
      bottomNavigationBar: BottomBar(),
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            children: [
              Container(
                height: 300,
                color: Colors.lightBlue,
                child: Center(
                  child: Text('holy'),
                ),
              ),
              Container(
                height: 350,
                color: Colors.lightGreen,
                child: Center(
                  child: Text('holy'),
                ),
              ),
              Container(
                height: 300,
                color: Colors.lightBlue,
                child: Center(
                  child: Text('holy'),
                ),
              ),
              Container(
                height: 350,
                color: Colors.lightGreen,
                child: Center(
                  child: Text('holy'),
                ),
              ),
              Container(
                height: 300,
                color: Colors.lightBlue,
                child: Center(
                  child: Text('holy'),
                ),
              ),
              Container(
                height: 350,
                color: Colors.lightGreen,
                child: Center(
                  child: Text('holy'),
                ),
              ),
            ],
            scrollDirection: Axis.vertical,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            staggeredTiles: [
              StaggeredTile.fit(1),
              StaggeredTile.fit(1),
              StaggeredTile.fit(1),
              StaggeredTile.fit(1),
              StaggeredTile.fit(1),
              StaggeredTile.fit(1),
            ],
          ),
        ),
      ],
    );
  }
}
