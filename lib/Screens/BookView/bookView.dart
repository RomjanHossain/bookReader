import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knowyourbook/Models/book/bookmod.dart';
import 'package:knowyourbook/Widgets/cartviewitem.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:knowyourbook/services/firebase/database.dart';
import 'package:knowyourbook/services/providers/cart.dart';
import 'package:knowyourbook/services/readBook/readFromDB.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class BookView extends StatefulWidget {
  static const String id = 'bookPage';
  BookView({
    this.bookid,
    this.des,
    this.author,
    this.buy,
    this.date,
    this.link,
    this.name,
    this.cat,
    this.uploader,
    this.rate,
    this.price,
  });
  final String bookid, des, author, name, link, uploader;
  final double rate;
  final int price;
  final Timestamp date;
  final bool buy;
  final List<dynamic> cat;

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //! save the file on dir

  final Dio dio = Dio();
  bool loading = false;
  double progress = 0;
  String _fileLoc;

  Future<bool> saveEpub(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      _fileLoc = directory.path + "/$fileName";
      // print(_fileLoc);
      if (await File(_fileLoc).exists()) {
        // print('file exists');
        return true;
      } else {
        // print('file downloading');
        if (await directory.exists()) {
          await dio.download(url, saveFile.path,
              onReceiveProgress: (value1, value2) {
            setState(() {
              progress = value1 / value2;
            });
          });
          return true;
        }
        return false;
      }
    } catch (e) {
      // print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  readBook() async {
    setState(() {
      loading = true;
      progress = 0;
    });
    bool downloaded = await saveEpub(widget.link, "${widget.bookid}.epub");
    if (downloaded) {
      _readDB.openBook(_fileLoc, widget.bookid);
    } else {
      // print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }

  //! file saved
  ReadFromDB _readDB = ReadFromDB();
  //? aert

  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context, listen: false);
    var _date = DateFormat.yMMMd().format(
        DateTime.fromMillisecondsSinceEpoch(widget.date.seconds * 1000));
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('book', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CartItemCount(),
          )
        ],
        leading: IconButton(
            icon: Icon(Icons.navigate_before, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
      ),
      // floatingActionButton: KReadBtn(
      //   onpressed: () async {
      //     //! read Book function goes here!
      //     Provider.of<DatabaseService>(context, listen: false)
      //         .updateReaded(widget.bookid);
      //     await readBook();
      //   },
      //   title: 'READ',
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        children: [
          loading
              ? LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.blue,
                  minHeight: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                )
              : SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
                children: [
                  TextSpan(
                    text: '${widget.name}\n',
                  ),
                  TextSpan(
                    text: 'uploaded by\t',
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.uploader}',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: widget.bookid,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.4,
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
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: FlatButton(
                    color: Color(0xFF4e4bf9),
                    onPressed: () {
                      if (widget.buy) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'added to cart',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.orangeAccent,
                            duration: Duration(seconds: 2),
                            onVisible: () {
                              BookModel _newBookmodel = BookModel(
                                name: widget.name,
                                price: widget.price,
                                bookid: widget.bookid,
                                numofItem: 0,
                              );

                              Provider.of<CartModel>(context, listen: false)
                                  .add(_newBookmodel);
                            },
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        showBuyBook(context, _user);
                      }
                    },
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    colorBrightness: Brightness.dark,
                    child: Text(
                      'Buy the Book',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text('${widget.author}'),
                  subtitle: Text('Author'),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('$_date'),
                  subtitle: Text('Date'),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('${widget.rate}'),
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
                for (dynamic ca in widget.cat)
                  MyBtn(
                    title: ca.toString(),
                    swapActive: true,
                  )
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
                    "${widget.des}",
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
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF292d36),
                      ),
                      child: IconButton(
                          color: Colors.red,
                          disabledColor: Colors.green,
                          focusColor: Colors.blue,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          tooltip: 'bookmark',
                          onPressed: () {
                            print('bookmark');
                          },
                          icon: Icon(CupertinoIcons.bookmark)),
                    ),
                  ),
                  // KReadBtn(
                  //   title: 'AudioBook',
                  //   onpressed: () async {
                  //     var _name = widget.name.toString().replaceAll(' ', '+');
                  //     String _url = _name + '+audiobook';
                  //     klaunchYoutube(_url);
                  //   },
                  // ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        color: Color(0xFFfa784a),
                        colorBrightness: Brightness.dark,
                        onPressed: () async {
                          //! read Book function goes here!
                          Provider.of<DatabaseService>(context, listen: false)
                              .updateReaded(widget.bookid);
                          await readBook();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('Start Reading'),
                      ),
                    ),
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
