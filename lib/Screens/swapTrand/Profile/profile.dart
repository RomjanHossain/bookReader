import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:knowyourbook/Screens/ordered/orderPage.dart';
import 'package:knowyourbook/Screens/upload/uploadPage.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:knowyourbook/services/firebase/auth.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class ProfileW extends StatefulWidget {
  @override
  _ProfileWState createState() => _ProfileWState();
}

class _ProfileWState extends State<ProfileW> {
  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 2,
            ),
            BoxShadow(
              color: Colors.blue,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: (Provider.of<User>(context) != null)
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.lightBlue.withOpacity(.2),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(_user.photoURL),
                        radius: 65,
                      ),
                      radius: 70,
                    ),
                    ListTile(
                      title: Center(
                        child: Text(
                          _user.displayName,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      subtitle: Center(child: Text(_user.email)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(LineIcons.book),
                        title: Text('My Book List'),
                        subtitle: Text('24'),
                        trailing: Icon(Icons.navigate_next),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.bookmarks_rounded),
                        title: Text('Bookmarks'),
                        subtitle: Text('23'),
                        trailing: Icon(Icons.navigate_next),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.upload_file),
                        title: Text('Uploaded'),
                        subtitle: Text('0'),
                        trailing: Icon(Icons.navigate_next),
                        onTap: () =>
                            Navigator.pushNamed(context, UpLoadPage.id),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(LineIcons.cart_arrow_down),
                        title: Text('Ordered'),
                        subtitle: Text('0'),
                        trailing: Icon(Icons.navigate_next),
                        onTap: () => Navigator.pushNamed(context, OrderPage.id),
                      ),
                    ),
                    MyBtn(
                      title: 'Log Out',
                      swapActive: true,
                      toggleSwap: () async {
                        print('pressed log out');
                        await Provider.of<AuthServices>(context, listen: false)
                            .signOut();
                      },
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 90,
                          backgroundImage: AssetImage(
                            'assets/images/SadFace.png',
                          ),
                        ),
                        Text(
                          '"Oh-Uh"',
                          style: TextStyle(
                            fontSize: 50,
                          ),
                        ),
                        Text(
                          'Sorry, could not find any account!',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Please, add your account',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                    MyBtn(
                      title: 'Log In',
                      swapActive: true,
                      toggleSwap: () async {
                        print('pressed log in');
                        await Provider.of<AuthServices>(context, listen: false)
                            .googleSignIn();
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
