import 'package:flutter/material.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';

class BookView extends StatefulWidget {
  static const String id = 'bookPage';
  BookView({this.index});
  final int index;
  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('book', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.navigate_before, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Scrollbar(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Moonwalking with Erick',
                style: TextStyle(color: Colors.black, fontSize: 25)),
            Hero(
              tag: '_book' + widget.index.toString(),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset(
                  'images/pro.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  height: 300,
                  // width: 250,
                ),
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Edward Carey'),
                    subtitle: Text('Author'),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Mov 12, 2018'),
                    subtitle: Text('Date'),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('4.6'),
                    subtitle: Text('RATING'),
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                MyBtn(
                  title: 'Comedy',
                  swapActive: true,
                ),
                MyBtn(
                  title: 'Romanctic',
                  swapActive: true,
                ),
                MyBtn(
                  title: 'Sci-fi',
                  swapActive: true,
                ),
                MyBtn(
                  title: 'Historical',
                  swapActive: true,
                ),
                MyBtn(
                  title: 'Drama',
                  swapActive: true,
                ),
              ],
            )),
            Container(
              color: Colors.red,
              height: 900,
            ),
          ],
        ),
      ),
    );
  }
}
