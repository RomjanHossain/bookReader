import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:knowyourbook/services/firebase/auth.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: (Provider.of<User>(context) != null)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          _user.photoURL,
                        ),
                        radius: 70,
                      ),
                      Text(
                        _user.displayName,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  )
                : Center(
                    child: MyBtn(
                      title: 'Log in',
                      swapActive: true,
                      toggleSwap: () async {
                        print('pressed log in');
                        await Provider.of<AuthServices>(context, listen: false)
                            .googleSignIn();
                      },
                    ),
                  ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // color: Colors.blue,
            child: FutureBuilder(
                future:
                    FirebaseFirestore.instance.collection('Tags').doc().get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    kloading();
                  }
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Text('Catagory'),
                      ListTile(
                        leading: Icon(Icons.emoji_nature),
                        title: Text('Action and Adventure'),
                      ),
                      ListTile(
                        leading: Icon(Icons.home_filled),
                        title: Text('Classics'),
                      ),
                      ListTile(
                        leading: Icon(Icons.graphic_eq),
                        title: Text('Graphic Novel'),
                      ),
                      ListTile(
                        leading: Icon(Icons.emoji_nature),
                        title: Text('Detective and Mystery'),
                      ),
                      ListTile(
                        leading: Icon(Icons.emoji_nature),
                        title: Text('Fantasy'),
                      ),
                      ListTile(
                        leading: Icon(Icons.emoji_nature),
                        title: Text('historical Fiction'),
                      ),
                      ListTile(
                        leading: Icon(Icons.emoji_nature),
                        title: Text('Horror'),
                      ),
                      ListTile(
                        leading: Icon(Icons.emoji_nature),
                        title: Text('Literary Fiction'),
                      ),
                      ListTile(
                        leading: Icon(Icons.emoji_nature),
                        title: Text('PolyTechnic BD'),
                      ),
                      ListTile(
                        leading: Icon(Icons.emoji_nature),
                        title: Text('Romance'),
                      ),
                      ListTile(
                        leading: Icon(Icons.emoji_nature),
                        title: Text('Science Fiction'),
                      ),
                      ListTile(
                        leading: Icon(Icons.emoji_nature),
                        title: Text('Short Stories'),
                      ),
                      ListTile(
                        leading: Icon(Icons.emoji_nature),
                        title: Text('Suspense and Thrillers'),
                      ),
                      ListTile(
                        leading: Icon(Icons.emoji_nature),
                        title: Text("women's Fiction"),
                      ),
                    ],
                  );
                }),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.blue, spreadRadius: 2, blurRadius: 2.55)
            ], color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.share,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Tell a friend'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.help_outline_rounded,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        showAboutDialog(
                            context: context,
                            applicationName: 'Know YOUR book',
                            applicationVersion: 'v0.0.1 (Beta Version)',
                            applicationLegalese:
                                '''This is a beta app for testing purposes! if you find any issue with this application, you can mail me at `romjanhossain726526@gmail.com`!
                              ''');
//                         );
                      },
                      child: Text('View Licence'),
                    ),
                  ],
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ],
    );
  }
}
