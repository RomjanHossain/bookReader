import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/services/firebase/auth.dart';
import 'package:knowyourbook/services/firebase/database.dart';
import 'package:knowyourbook/services/firebase/storage.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:provider/provider.dart';

//? animation for upload fomr
Route uploadFormPageAnimation() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => RealUpPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, -1.0);
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

class RealUpPage extends StatefulWidget {
  static const String id = 'realup';
  @override
  _RealUpPageState createState() => _RealUpPageState();
}

class _RealUpPageState extends State<RealUpPage> {
  String _bookName, _bookDescription;
  List<String> _bookCatagory = [];
  bool _isUploading = false;
  final _globalKey = GlobalKey<ScaffoldState>();
  List<Widget> _listofCat = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    File _epub;
    return Scaffold(
      key: _globalKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Upload Book',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () {
            _isUploading ? print('uploading') : Navigator.pop(context);
          },
        ),
      ),
      body: _isUploading
          ? Stack(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator()),
                Align(
                  alignment: Alignment.center,
                  child: Text('wait til its done....!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      )),
                )
              ],
            )
          : Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //? name field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //? name Field
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: TextFormField(
                          onSaved: (txt) => _bookName = txt,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Book Name',
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                )),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                )),
                            hintText: 'Shoe Dog',
                          ),
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),

                      //? description field
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          onSaved: (txt) => _bookDescription = txt,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          autocorrect: false,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                )),
                            labelText: 'Description',
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                )),
                          ),
                          keyboardType: TextInputType.text,
                          maxLines: 10,
                          textAlign: TextAlign.center,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'BookCategory',
                        ),
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (Widget i in _listofCat) i,
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: PopupMenuButton<BookCategory>(
                                icon: Icon(Icons.add),
                                onSelected: (BookCategory result) {
                                  setState(() {
                                    _bookCatagory.add(
                                      result.toString().substring(
                                          result.toString().indexOf('.') + 1),
                                    );
                                    _listofCat.add(
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          onPressed: () {},
                                          child: Text(
                                            result.toString().substring(
                                                result.toString().indexOf('.') +
                                                    1),
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          color: Color(0xFFAFCCF5),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<BookCategory>>[
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Action,
                                    child: Text('Action'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Adventure,
                                    child: Text('Adventure'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Adult,
                                    child: Text('Adult'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Biography,
                                    child: Text('Biography'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Classics,
                                    child: Text('Classics'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Cultural,
                                    child: Text('Cultural'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Detective,
                                    child: Text('Detective'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Fantasy,
                                    child: Text('Fantasy'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Historical,
                                    child: Text('Historical'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Horror,
                                    child: Text('Horror'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Literacy,
                                    child: Text('Literacy'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Mystery,
                                    child: Text('Mystery'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Novels,
                                    child: Text('Novels'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Poetry,
                                    child: Text('Poetry'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Psychology,
                                    child: Text('Psychology'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Philosophy,
                                    child: Text('Philosophy'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Romance,
                                    child: Text('Romance'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Religion,
                                    child: Text('Religion'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Science,
                                    child: Text('Science'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Selfhelp,
                                    child: Text('Self-help'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Short,
                                    child: Text('Short'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Social,
                                    child: Text('Social'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Suspense,
                                    child: Text('Suspense'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Thrillers,
                                    child: Text('Thrillers'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Feminism,
                                    child: Text('Feminism'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.Womens,
                                    child: Text('Womens'),
                                  ),
                                  const PopupMenuItem<BookCategory>(
                                    value: BookCategory.ScienceFiction,
                                    child: Text('Science Fiction'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //? epub file
                      GestureDetector(
                        onTap: () async {
                          File _file =
                              await Provider.of<FirebaseStorageService>(context,
                                      listen: false)
                                  .pickFile();
                          if (_file != null) {
                            _epub = _file;
                            // setState(() {
                            //   _epub = _file;
                            // });
                          } else {
                            //? user cancelled
                            var snackBar = kownBar('Canceled', Colors.red);
                            _globalKey.currentState.showSnackBar(snackBar);
                            // Navigator.pop(context);
                          }
                        },
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.blue,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: SizedBox(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Center(
                                child: Image.asset('assets/images/epub2.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //? img file
                      GestureDetector(
                        onTap: () async {
                          File _file =
                              await Provider.of<FirebaseStorageService>(context,
                                      listen: false)
                                  .pickImageFile();
                          if (_file != null) {
                            _epub = _file;
                            // setState(() {
                            //   _epub = _file;
                            // });
                          } else {
                            //? user cancelled
                            var snackBar = kownBar('Canceled', Colors.red);
                            _globalKey.currentState.showSnackBar(snackBar);
                            // Navigator.pop(context);
                          }
                        },
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.blue,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: SizedBox(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Cover Image'),
                                  Icon(
                                    Icons.image,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: FlatButton(
                      color: Colors.blue,
                      colorBrightness: Brightness.dark,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      onPressed: () async {
                        //? upload it to firebase storage
                        if (_bookCatagory.isEmpty) {
                          var snackBar = kownBar(
                              'BookCategory must not be empty',
                              Colors.redAccent);
                          _globalKey.currentState.showSnackBar(snackBar);
                        }
                        if (_epub == null) {
                          var snackBar =
                              kownBar('epub file needed', Colors.redAccent);
                          _globalKey.currentState.showSnackBar(snackBar);
                        }

                        if (_formKey.currentState.validate() &&
                            _bookCatagory.isNotEmpty &&
                            _epub != null) {
                          _formKey.currentState.save();

                          setState(() {
                            _isUploading = true;
                          });
                          await Provider.of<FirebaseStorageService>(context,
                                  listen: false)
                              .uploadFile(_epub, user)
                              .then((String bookid) async {
                            await Provider.of<AuthServices>(context,
                                    listen: false)
                                .userUploaded(bookid, user);

                            await Provider.of<DatabaseService>(context,
                                    listen: false)
                                .initBook(
                              user,
                              bookid,
                              _bookName,
                              _bookDescription,
                              _bookCatagory,
                              await Provider.of<FirebaseStorageService>(context,
                                      listen: false)
                                  .downloadURL(user.uid, bookid),
                            );

                            var snackBar = kownBar('Uploaded', Colors.green);
                            _globalKey.currentState.showSnackBar(snackBar);

                            setState(() {
                              _isUploading = false;
                            });
                            Future.delayed(Duration(seconds: 1),
                                () => Navigator.pop(context));
                          });
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
