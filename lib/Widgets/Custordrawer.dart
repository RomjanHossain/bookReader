import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/Screens/category/viewcat.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:knowyourbook/services/firebase/auth.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  viewAllCat(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext conetxt) {
    return snapshot.data.docs
        .map(
          (doc) => ListTile(
              // leading: Icon(getIcon(BookCategory.)),
              onTap: () => Navigator.of(conetxt).push(createRoute(doc)),
              title: Text(doc.id.toString()),
              subtitle: Text(doc.data().length.toString())
              // subtitle: Text(
              //   doc["amount"].toString(),
              // ),
              ),
        )
        .toList();
  }

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
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('Tags').snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView(
                            physics: BouncingScrollPhysics(),
                            // Navigator.of(context).push(createRoute());
                            children: viewAllCat(snapshot, context),
                          )
                        : kloading();
                  })),
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
