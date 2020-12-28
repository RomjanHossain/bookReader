import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/Screens/swapTrand/TopGrowsing/components/bookcardGrow.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:knowyourbook/services/firebase/database.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:provider/provider.dart';

class TopGrow extends StatefulWidget {
  @override
  _TopGrowState createState() => _TopGrowState();
}

class _TopGrowState extends State<TopGrow> {
  int _number = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Expanded(
            child: TabBar(
              onTap: (int lol) {
                setState(() {
                  _number = lol;
                });
              },
              isScrollable: true,
              indicatorColor: Colors.transparent,
              tabs: [
                MyBtn(
                  title: 'Top Week',
                  swapActive: _number == 0 ? true : false,
                ),
                MyBtn(
                  title: 'Top Month',
                  swapActive: _number == 1 ? true : false,
                ),
                MyBtn(
                  title: 'Top Year',
                  swapActive: _number == 2 ? true : false,
                ),
                MyBtn(
                  title: 'Top All Time',
                  swapActive: _number == 3 ? true : false,
                ),
              ],
            ),
          ),
          // end of experiment
          Expanded(
            flex: 8,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                //? top week
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('All Book')
                        .orderBy(
                          'views week',
                          descending: true,
                        )
                        .limitToLast(10)
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
                                  child: BookCardGrowing(
                                    desc: snapshot.data.docs[index]
                                        ['description'],
                                    docID: snapshot.data.docs[index].documentID,
                                    index: index,
                                    name: snapshot.data.docs[index]['name'],
                                    readed: snapshot.data.docs[index]['readed']
                                        .toString(),
                                    views: snapshot
                                        .data.docs[index]['views alltime']
                                        .toString(),
                                  ),
                                );
                              },
                            )
                          : kloading();
                    }),
                // sec[exception]
                //? top month
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('All Book')
                        .orderBy(
                          'views month',
                          descending: true,
                        )
                        .limitToLast(10)
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
                                  child: BookCardGrowing(
                                    desc: snapshot.data.docs[index]
                                        ['description'],
                                    docID: snapshot.data.docs[index].documentID,
                                    index: index,
                                    name: snapshot.data.docs[index]['name'],
                                    readed: snapshot.data.docs[index]['readed']
                                        .toString(),
                                    views: snapshot
                                        .data.docs[index]['views month']
                                        .toString(),
                                  ),
                                );
                              },
                            )
                          : kloading();
                    }),
                //? top year
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('All Book')
                        .orderBy(
                          'views year',
                          descending: true,
                        )
                        .limitToLast(10)
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
                                  child: BookCardGrowing(
                                    desc: snapshot.data.docs[index]
                                        ['description'],
                                    docID: snapshot.data.docs[index].documentID,
                                    index: index,
                                    name: snapshot.data.docs[index]['name'],
                                    readed: snapshot.data.docs[index]['readed']
                                        .toString(),
                                    views: snapshot
                                        .data.docs[index]['views year']
                                        .toString(),
                                  ),
                                );
                              },
                            )
                          : kloading();
                    }),
                //? all time
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('All Book')
                        .orderBy(
                          'views alltime',
                          descending: true,
                        )
                        .limitToLast(10)
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
                                  child: BookCardGrowing(
                                    desc: snapshot.data.docs[index]
                                        ['description'],
                                    docID: snapshot.data.docs[index].documentID,
                                    index: index,
                                    name: snapshot.data.docs[index]['name'],
                                    readed: snapshot.data.docs[index]['readed']
                                        .toString(),
                                    views: snapshot
                                        .data.docs[index]['views alltime']
                                        .toString(),
                                  ),
                                );
                              },
                            )
                          : kloading();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
