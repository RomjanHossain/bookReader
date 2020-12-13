import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/Screens/swapTrand/Bookmark/bookmarks.dart';
import 'package:knowyourbook/Screens/swapTrand/Home/books.dart';
import 'package:knowyourbook/Screens/swapTrand/Profile/profile.dart';
import 'package:knowyourbook/Screens/swapTrand/TopGrowsing/topGrowsing.dart';
import 'package:knowyourbook/Widgets/Custordrawer.dart';
import 'package:knowyourbook/Widgets/bottomNavBar.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

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
      style: tabbarTextColor,
    ),
    Text(
      'Top Growsing',
      style: tabbarTextColor,
    ),
    Text(
      'Bookmarks',
      style: tabbarTextColor,
    ),
    Text(
      'Profile',
      style: tabbarTextColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context);
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
        actions: (_selectedIndex == 0)
            ? [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.search, color: Colors.black, size: 30),
                )
              ]
            : [],
      ),
      bottomNavigationBar: BottomBar(
        sInd: _selectedIndex,
        onp: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: MyHomePage.myPages.elementAt(_selectedIndex),
    );
  }
}
