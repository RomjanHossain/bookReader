import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:knowyourbook/services/firebase/database.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:provider/provider.dart';

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
              physics: NeverScrollableScrollPhysics(),
              children: [
                //? new Books
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('All Book')
                      .orderBy('upload Date')
                      .get(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? StaggeredGridView.countBuilder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Provider.of<DatabaseService>(context,
                                          listen: false)
                                      .viewUpdate(
                                          snapshot.data.docs[index].documentID);
                                  Navigator.push(
                                    context,
                                    pushToBookView(snapshot, index),
                                  );
                                },
                                child: Hero(
                                  tag: snapshot.data.docs[index].documentID,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              alignment: Alignment.center,
                                              fit: BoxFit.cover,
                                              image:
                                                  AssetImage('images/pro.jpg'),
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
                                              text:
                                                  '${snapshot.data.docs[index]["name"]}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: snapshot.data.docs.length,
                            staggeredTileBuilder: (index) {
                              return StaggeredTile.count(
                                1,
                                index.isEven ? 1.6 : 1.8,
                              );
                            },
                            crossAxisCount: 2,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            scrollDirection: Axis.vertical,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          )
                        : kloading();
                  },
                ),

                //? most popular
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('All Book')
                        .orderBy('readed', descending: true)
                        .get(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? StaggeredGridView.countBuilder(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Provider.of<DatabaseService>(context,
                                            listen: false)
                                        .viewUpdate(snapshot
                                            .data.docs[index].documentID);
                                    Navigator.push(
                                      context,
                                      pushToBookView(snapshot, index),
                                    );
                                  },
                                  child: Hero(
                                    tag: snapshot.data.docs[index].documentID,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                alignment: Alignment.center,
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'images/pro.jpg'),
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
                                                text:
                                                    '${snapshot.data.docs[index]["name"]}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data.docs.length,
                              staggeredTileBuilder: (index) {
                                return StaggeredTile.count(1, 1.5);
                              },
                              crossAxisCount: 2,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              scrollDirection: Axis.vertical,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            )
                          : kloading();
                    }),
                //? Tranding
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('All Book')
                        .orderBy('views')
                        .limitToLast(20)
                        .get(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Provider.of<DatabaseService>(context,
                                            listen: false)
                                        .viewUpdate(snapshot
                                            .data.docs[index].documentID);
                                    Navigator.push(
                                      context,
                                      pushToBookView(snapshot, index),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blue.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '#${index + 1} ',
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                        Expanded(
                                          child: Hero(
                                            tag: snapshot
                                                .data.docs[index].documentID,
                                            child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage(
                                                    'images/pro.jpg')),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: ListTile(
                                            title: Text(snapshot
                                                .data.docs[index]["name"]),
                                            subtitle: Text(
                                              snapshot.data.docs[index]
                                                  ["description"],
                                              style: TextStyle(
                                                wordSpacing: .4,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : kloading();
                    }),
                //? requested
                StaggeredGridView.count(
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  children: [
                    Text('lodkf'),
                    Text('djfskldf'),
                  ],
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
