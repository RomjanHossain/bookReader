import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/services/firebase/auth.dart';
import 'package:knowyourbook/services/firebase/storage.dart';
import 'package:provider/provider.dart';

enum tags { harder, smarter, selfStarter, tradingCharter }

class UpLoadPage extends StatefulWidget {
  static const String id = 'upload';

  @override
  _UpLoadPageState createState() => _UpLoadPageState();
}

class _UpLoadPageState extends State<UpLoadPage> {
  List<Widget> _listofCat = [
    Text('Tags'),
    // FloatingActionButton(
    //   onPressed: () {

    //       _listofCat.add(Text('skdjfl'));

    //   },
    //   mini: true,
    //   elevation: 3,
    //   child: Icon(Icons.add),
    // ),
  ];
  final _globalKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _isUploading = false;
  void displayBottomSheet(BuildContext context, User user) {
    showGeneralDialog(
      barrierLabel: '',
      barrierDismissible: true,
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        scrollable: true,
        title: Center(
            child: Center(
          child: Text('Upload your Book'),
        )),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //? name field
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Romjan Hossain',
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              //? description field
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                maxLines: 10,
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.sentences,
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _listofCat,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  File _file = await Provider.of<FirebaseStorageService>(
                          context,
                          listen: false)
                      .pickFile();
                  if (_file != null) {
                    //? upload it to firebase storage
                    Navigator.pop(context);
                    // LinearProgressIndicator(
                    //   key: _globalKey,
                    // );
                    setState(() {
                      _isUploading = true;
                    });
                    await Provider.of<FirebaseStorageService>(context,
                            listen: false)
                        .uploadFile(_file, user)
                        .then((String bookid) {
                      Provider.of<AuthServices>(context, listen: false)
                          .userUploaded(bookid, user);
                      var snackBar = _ownBar('Uploaded', Colors.green);
                      _globalKey.currentState.showSnackBar(snackBar);
                      setState(() {
                        _isUploading = false;
                      });
                    });
                  } else {
                    //? user cancelled
                    Navigator.pop(context);
                    var snackBar = _ownBar('Canceled', Colors.red);
                    _globalKey.currentState.showSnackBar(snackBar);
                  }
                },
                child: Container(
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
                    child:
                        Center(child: Image.asset('assets/images/epub2.png')),
                  ),
                ),
              ),
              FlatButton(
                color: Colors.blue,
                colorBrightness: Brightness.dark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () {},
                child: Text('Submit'),
              ),
            ],
          ),
        ),
        elevation: 2,
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          child: child,
          opacity: anim1,
        ),
      ),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return Scaffold(
      key: _globalKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayBottomSheet(context, user);
          //! showend
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
            color: Colors.black,
          ),
          onPressed: () {
            _isUploading ? print('') : Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Upload',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          _isUploading ? LinearProgressIndicator() : Text(''),
          Center(
            child: Text('Empty'),
          ),
        ],
      ),
    );
  }

  SnackBar _ownBar(String txt, Color col) {
    return SnackBar(
      backgroundColor: col,
      behavior: SnackBarBehavior.fixed,
      duration: Duration(seconds: 20),
      content: Text(
        txt,
        style: TextStyle(color: Colors.black, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
