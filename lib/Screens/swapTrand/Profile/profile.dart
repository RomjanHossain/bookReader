import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:knowyourbook/Screens/ordered/orderPage.dart';
import 'package:knowyourbook/Screens/swapTrand/Profile/components/notloggedin.dart';
import 'package:knowyourbook/Screens/upload/uploadPage.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:knowyourbook/services/firebase/auth.dart';
import 'package:knowyourbook/services/firebase/database.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class ProfileW extends StatefulWidget {
  @override
  _ProfileWState createState() => _ProfileWState();
}

class _ProfileWState extends State<ProfileW> {
  @override
  void dispose() {
    super.dispose();
  }

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
                      child: FutureBuilder(
                          future: Provider.of<DatabaseService>(context,
                                  listen: false)
                              .getBookmarkLength(_user.uid),
                          builder: (context, snapshot) {
                            return ListTile(
                              leading: Icon(Icons.bookmarks_rounded),
                              title: Text('Bookmarks'),
                              subtitle: (snapshot.hasData)
                                  ? Text(snapshot.data.toString())
                                  : Text('0'),
                            );
                          }),
                    ),
                    Card(
                      child: FutureBuilder(
                          future: Provider.of<DatabaseService>(context)
                              .uploadOrder(_user),
                          builder: (context, snapshot) {
                            return ListTile(
                              leading: Icon(Icons.upload_file),
                              title: Text('Uploaded'),
                              subtitle: (snapshot.hasData)
                                  ? Text(snapshot.data.toString())
                                  : Text('0'),
                              trailing: Icon(Icons.navigate_next),
                              onTap: () => Navigator.of(context)
                                  .push(uploadPageAnimation(_user.uid)),
                            );
                          }),
                    ),
                    Card(
                      child: FutureBuilder(
                        future: Provider.of<DatabaseService>(context)
                            .countOrder(_user),
                        builder: (context, snapshot) {
                          return ListTile(
                            leading: Icon(LineIcons.cart_arrow_down),
                            title: Text('Ordered'),
                            subtitle: (snapshot.hasData)
                                ? Text(snapshot.data.toString())
                                : Text('0'),
                            trailing: Icon(Icons.navigate_next),
                            onTap: () => Navigator.of(context)
                                .push(orderPageAnimation(_user.uid)),
                          );
                        },
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
            : NotLoggedIn(),
      ),
    );
  }
}
