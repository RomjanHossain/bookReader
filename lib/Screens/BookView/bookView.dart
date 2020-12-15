import 'package:flutter/material.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:knowyourbook/services/readBook/readFromAsset.dart';

class BookView extends StatefulWidget {
  static const String id = 'bookPage';
  BookView({this.index});
  final int index;
  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  ReadBookFromAsset _readasset = ReadBookFromAsset();

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
      floatingActionButton: KReadBtn(
        onpressed: () {
          //! read Book function goes here!
          print('hol');
          _readasset.openBook();
        },
        title: 'READ',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Column(
              children: [
                Text('Moonwalking with Erick',
                    style: TextStyle(color: Colors.black, fontSize: 25)),
                Text('by Albert Manson'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Hero(
              tag: '_book' + widget.index.toString(),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset(
                  'images/pro.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  height: 400,
                  // width: 250,
                ),
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
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
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
            ),
          ),
          Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Moonwalking witjfl;ksadjflkasjdfl;kasjdfl;kasjdflkasdjfl;kasjdfl;kasjdf;slakjdfls;akjdfl;sakdjfl;aksdjfl;aksdjl;fkasjdl;kfjash Einstein: The Art and Science of ...www.amazon.com › Moonwalking-Einstein-Science-Re...An instant bestseller that is poised to become a classic, Moonwalking with Einstein recounts Joshua Foer's yearlong quest to improve his memory under the tutelage of top mental athletes He draws on cutting-edge research, a surprising cultural history of remembering, and venerable tricks of the mentalist's trade to",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 130,
            // color: Colors.red,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 50,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  KReadBtn(
                    title: 'AudioBook',
                    onpressed: null,
                  ),
                  KReadBtn(
                    title: 'Buy Now',
                    onpressed: null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
