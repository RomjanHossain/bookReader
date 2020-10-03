import 'package:flutter/material.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:line_icons/line_icons.dart';

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
              children: [
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
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
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              child: Image.network(
                                'https://i.pinimg.com/originals/62/04/3b/62043b0bb353f49600a23ed1b5ec922f.jpg',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    'Moonwalking with Eienstain',
                                    style: kTitle,
                                  ),
                                  subtitle: Text(
                                    'there are just too many ksjlskajd fksdj skdfj;slkdjsl;kdfjl;skdjfsl;kdjf;slkdjfskdjf;slkdjfslkdjf;asdk times that ',
                                    style: kSubtitle,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    KSmallBtn(
                                      iconData: LineIcons.eye,
                                      text: '1412',
                                    ),
                                    KSmallBtn(
                                      iconData: LineIcons.book,
                                      text: '1000',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // sec[exception]
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
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
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://i.pinimg.com/originals/62/04/3b/62043b0bb353f49600a23ed1b5ec922f.jpg'),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: ListTile(
                              title: Text('The Pain of Others'),
                              subtitle: Text(
                                  'there are just too many ksjlskajd fksdj skdfj;slkdjsl;kdfjl;skdjfsl;kdjf;slkdjfskdjf;slkdjfslkdjf;asdk times that people have trying to look inside of me wondering what you toough'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // another [lol]
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
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
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://i.pinimg.com/originals/62/04/3b/62043b0bb353f49600a23ed1b5ec922f.jpg'),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: ListTile(
                              title: Text(
                                'Whay',
                                style: kTitle,
                              ),
                              subtitle: Text(
                                  'there are just too many ksjlskajd fksdj skdfj;slkdjsl;kdfjl;skdjfsl;kdjf;slkdjfskdjf;slkdjfslkdjf;asdk times that people have trying to look inside of me wondering what you toough'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // anoo[xD]
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
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
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://i.pinimg.com/originals/62/04/3b/62043b0bb353f49600a23ed1b5ec922f.jpg'),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: ListTile(
                              title: Text('Holy'),
                              subtitle: Text(
                                  'there are just too many ksjlskajd fksdj skdfj;slkdjsl;kdfjl;skdjfsl;kdjf;slkdjfskdjf;slkdjfslkdjf;asdk times that people have trying to look inside of me wondering what you toough'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
