import 'package:flutter/material.dart';
import 'package:knowyourbook/Screens/swapTrand/bookmarks.dart';
import 'package:knowyourbook/Screens/swapTrand/books.dart';
import 'package:knowyourbook/Screens/swapTrand/profile.dart';
import 'package:knowyourbook/Screens/swapTrand/topGrowsing.dart';
import 'package:knowyourbook/Widgets/Custordrawer.dart';
import 'package:knowyourbook/Widgets/bottomNavBar.dart';
import 'package:line_icons/line_icons.dart';

class MyHomePage extends StatefulWidget {
  static const String id = 'homepage';
  static List<Widget> myPages = [
    HomePage(),
    TopGrow(),
    BookMarks(),
    ProfileW(),
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Text> _titles = [
    Text(
      'All Books',
      style: TextStyle(color: Colors.black),
    ),
    Text(
      'Top Growsing',
      style: TextStyle(color: Colors.black),
    ),
    Text(
      'Bookmarks',
      style: TextStyle(color: Colors.black),
    ),
    Text(
      'Profile',
      style: TextStyle(color: Colors.black),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        title: _titles[_selectedIndex],
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(
              LineIcons.navicon,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        actions: _selectedIndex == 3
            ? []
            : [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.search, color: Colors.black, size: 30),
                )
              ],
      ),
      bottomNavigationBar: BottomBar(
        sInd: _selectedIndex,
        onp: (index) {
          setState(() {
            _selectedIndex = index;
            print(_selectedIndex);
          });
        },
      ),
      body: MyHomePage.myPages.elementAt(_selectedIndex),
    );
  }
}
