import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:knowyourbook/Screens/BookView/bookView.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';

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
  List<Widget> books = [
    Container(
      height: 250,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text('Mnly'),
      ),
    ),
    Container(
      height: 300,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text('holy'),
      ),
    ),
    Container(
      height: 250,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text('holy'),
      ),
    ),
    Container(
      height: 300,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text('holy'),
      ),
    ),
    Container(
      height: 250,
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text('holy'),
      ),
    ),
    Container(
      height: 300,
      decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://i.pinimg.com/originals/62/04/3b/62043b0bb353f49600a23ed1b5ec922f.jpg',
            ),
          ),
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
    ),
  ];
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
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookView(
                                        bookid: snapshot
                                            .data.docs[index].documentID,
                                        author: snapshot.data.docs[index]
                                            ["author"],
                                        buy: snapshot.data.docs[index]["buy"],
                                        cat: snapshot.data.docs[index]
                                            ["Categorys"],
                                        link: snapshot.data.docs[index]
                                            ["Download URL"],
                                        date: snapshot.data.docs[index]
                                            ["upload Date"],
                                        des: snapshot.data.docs[index]
                                            ["description"],
                                        name: snapshot.data.docs[index]["name"],
                                        rate: snapshot.data.docs[index]
                                            ["rating"],
                                        uploader: snapshot.data.docs[index]
                                            ["uploader"],
                                      ),
                                    ),
                                  ),
                                  child: Hero(
                                    tag: snapshot.data.docs[index].documentID,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            // height: 300,
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
                          : Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.redAccent,
                                  ),
                                ),
                              ],
                            );
                    }),
                //? most popular
                StaggeredGridView.countBuilder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, BookView.id);
                      },
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.network(
                            'https://i.pinimg.com/originals/62/04/3b/62043b0bb353f49600a23ed1b5ec922f.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 10,
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, 1.5);
                  },
                  crossAxisCount: 2,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                //? Tranding
                StaggeredGridView.count(
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 4,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  children: books,
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  staggeredTiles: mystaggeredTiles,
                ),
                //? requested
                StaggeredGridView.count(
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  children: books,
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
