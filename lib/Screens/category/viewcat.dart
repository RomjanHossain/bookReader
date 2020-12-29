import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/Screens/BookView/bookView.dart';
import 'package:knowyourbook/services/firebase/database.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:provider/provider.dart';

Route createRoute(QueryDocumentSnapshot val) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ViewCat(
      vals: val,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

class ViewCat extends StatelessWidget {
  ViewCat({this.vals});
  final QueryDocumentSnapshot vals;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          vals.id.toString(),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height),
        physics: BouncingScrollPhysics(),
        children: [
          // Text(vals.data().toString()),
          for (var i in vals.data().keys)
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("All Book")
                    .doc(i.toString())
                    .get(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? InkWell(
                          onTap: () {
                            Provider.of<DatabaseService>(context, listen: false)
                                .viewUpdate(snapshot.data.documentID);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookView(
                                  bookid: snapshot.data.documentID,
                                  author: snapshot.data["author"],
                                  buy: snapshot.data["buy"],
                                  cat: snapshot.data["Categorys"],
                                  link: snapshot.data["Download URL"],
                                  date: snapshot.data["upload Date"],
                                  des: snapshot.data["description"],
                                  name: snapshot.data["name"],
                                  rate: snapshot.data["rating"],
                                  uploader: snapshot.data["uploader"],
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: snapshot.data.documentID,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 15,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        alignment: Alignment.center,
                                        fit: BoxFit.cover,
                                        image: AssetImage('images/pro.jpg'),
                                      ),
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                        // '${snapshot.data.docs[index]["name"]}',
                                      ),
                                    ),
                                  ),
                                ),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${snapshot.data["name"]}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          ),
                        )
                      : kloading();
                })
          // vals.data().forEach((key, value) {return Text()})
        ],
      ),
    );
  }
}
