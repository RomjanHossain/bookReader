import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/services/firebase/auth.dart';
import 'package:knowyourbook/services/firebase/database.dart';
import 'package:knowyourbook/services/firebase/storage.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:provider/provider.dart';

class RealUpPage extends StatefulWidget {
  static const String id = 'realup';
  @override
  _RealUpPageState createState() => _RealUpPageState();
}

class _RealUpPageState extends State<RealUpPage> {
  String _bookName;
  String _bookDescription;
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
            _isUploading ? print('') : Navigator.pop(context);
          },
        ),
      ),
      body: _isUploading
          ? LinearProgressIndicator()
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
                          onSaved: (value) {
                            print(value);
                            setState(() {
                              _bookName = value;
                              print('book name $_bookName');
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
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
                          onSaved: (value) {
                            print(value);
                            setState(() {
                              _bookDescription = value;
                              print('book description $_bookDescription');
                            });
                          },
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
                          'category',
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
                              child: PopupMenuButton<Category>(
                                icon: Icon(Icons.add),
                                onSelected: (Category result) {
                                  setState(() {
                                    _bookCatagory.add('$result');
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
                                    <PopupMenuEntry<Category>>[
                                  const PopupMenuItem<Category>(
                                    value: Category.Action,
                                    child: Text('Action'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Adventure,
                                    child: Text('Adventure'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Adult,
                                    child: Text('Adult'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Classics,
                                    child: Text('Classics'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Detective,
                                    child: Text('Detective'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Fantasy,
                                    child: Text('Fantasy'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Historical,
                                    child: Text('Historical'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Horror,
                                    child: Text('Horror'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Literacy,
                                    child: Text('Literacy'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Mystery,
                                    child: Text('Mystery'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Romance,
                                    child: Text('Romance'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Short,
                                    child: Text('Short'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Suspense,
                                    child: Text('Suspense'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Thrillers,
                                    child: Text('Thrillers'),
                                  ),
                                  const PopupMenuItem<Category>(
                                    value: Category.Women,
                                    child: Text('Women Friction'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //? file
                      GestureDetector(
                        onTap: () async {
                          File _file =
                              await Provider.of<FirebaseStorageService>(context,
                                      listen: false)
                                  .pickFile();
                          if (_file != null) {
                            setState(() {
                              _epub = _file;
                            });
                          } else {
                            //? user cancelled
                            var snackBar = kownBar('Canceled', Colors.red);
                            _globalKey.currentState.showSnackBar(snackBar);
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
                              'Category must not be empty', Colors.redAccent);
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
                          setState(() {
                            _isUploading = true;
                          });
                          await Provider.of<FirebaseStorageService>(context,
                                  listen: false)
                              .uploadFile(_epub, user)
                              .then((String bookid) async {
                            Provider.of<AuthServices>(context, listen: false)
                                .userUploaded(bookid, user);
                            String _dl =
                                await Provider.of<FirebaseStorageService>(
                                        context)
                                    .downloadURL(user.uid, bookid);
                            Provider.of<DatabaseService>(context, listen: false)
                                .allbook(
                              bookid,
                              user,
                              _bookName,
                              _bookDescription,
                              _bookCatagory,
                              _dl,
                            );
                            var snackBar = kownBar('Uploaded', Colors.green);
                            _globalKey.currentState.showSnackBar(snackBar);
                            setState(() {
                              _isUploading = false;
                            });
                            Navigator.pop(context);
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
