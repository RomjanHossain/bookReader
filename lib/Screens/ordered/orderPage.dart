import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:intl/intl.dart';

//? animation for order page
Route orderPageAnimation(String uid) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        OrderPage(uid: uid),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 1.0);
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

class OrderPage extends StatelessWidget {
  static const String id = 'order';
  OrderPage({this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Ordered',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Users')
            .doc(uid)
            .collection('ordered')
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (_, i) {
                    return Container(
                      height: 300,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (String name in snapshot.data.docs[i]
                              ['book_name'])
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Book name'),
                                Text(
                                  name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('is user Received order'),
                              Text(snapshot.data.docs[i]['completed']
                                  .toString()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Order Date'),
                              Text(
                                  '${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.docs[i]['order Data'].seconds * 1000))}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Total'),
                              Text(snapshot.data.docs[i]['total'].toString()),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: snapshot.data.docs.length,
                )
              : kloading();
        },
      ),
    );
  }
}
