import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/services/firebase/storage.dart';
import 'package:provider/provider.dart';

class UpLoadPage extends StatefulWidget {
  static const String id = 'upload';

  @override
  _UpLoadPageState createState() => _UpLoadPageState();
}

class _UpLoadPageState extends State<UpLoadPage> {
  final _globalKey = GlobalKey<ScaffoldState>();
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return Scaffold(
      key: _globalKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showGeneralDialog(
            barrierDismissible: true,
            barrierLabel: '',
            barrierColor: Colors.black38,
            pageBuilder: (ctx, anim1, anim2) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              scrollable: true,
              title: Center(
                  child: Center(
                child: Text('Upload your Epub file'),
              )),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                            .then((_) {
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
                      padding: EdgeInsets.symmetric(
                        vertical: 80,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Center(
                            child: Image.asset('assets/images/epub2.png')),
                      ),
                    ),
                  ),
                ],
              ),
              elevation: 2,
            ),
            transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
              child: FadeTransition(
                child: child,
                opacity: anim1,
              ),
            ),
            context: context,
          );

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
          onPressed: () => Navigator.pop(context),
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
