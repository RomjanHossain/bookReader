import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

const kTitle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w400,
  fontSize: 20,
);

const kSubtitle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w300,
  fontSize: 16,
  letterSpacing: 2,
);

kToggleSwap(val) {
  val ? val = !val : val = !val;
}

const tabbarTextColor = TextStyle(color: Colors.black);

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

//? catagory
enum Category {
  Action,
  Adventure,
  Biography,
  Classics,
  Cultural,
  Detective,
  Mystery,
  Novels,
  Fantasy,
  Historical,
  Horror,
  Literacy,
  Poetry,
  Romance,
  Religion,
  Psychology,
  Philosophy,
  Science,
  Selfhelp,
  Short,
  Social,
  Suspense,
  Thrillers,
  Feminism,
  Adult,
  Womens,
  ScienceFiction,
}
//? snak bar
SnackBar kownBar(String txt, Color col) {
  return SnackBar(
    backgroundColor: col,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 1),
    content: Text(
      txt,
      style: TextStyle(color: Colors.black, fontSize: 20),
      textAlign: TextAlign.center,
    ),
  );
}

//? take user to youtube!!!
Future<void> klaunchYoutube(String bookname) async {
  //https://www.youtube.com/results?search_query=%s
  // final String url = 'www.youtube.com/results?search_query=$bookname';
  String url = 'https://youtube.com/results?search_query=$bookname';
  print(url);
  if (await canLaunch('$url')) {
    await launch(
      url,
      forceSafariVC: false,
      universalLinksOnly: true,
      forceWebView: false,
    );
  } else {
    await launch(
      '$url',
      forceSafariVC: true,
      universalLinksOnly: true,
    );
  }
}

//! upload method
//? show
// void showView(BuildContext context) {
//   // set up the button
//   Widget okButton = FlatButton(
//     child: Text("Read"),
//     onPressed: () {
//       Navigator.pop(context);
//     },
//   );

//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text("My title"),
//     content: Text("This is my message."),
//     actions: [
//       okButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

/*
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _listofCat,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        _listofCat.add(Text('skdjfl'));
                      });
                    },
                    fillColor: Colors.white.withOpacity(.7),
                    child: Icon(Icons.add),
                    shape: CircleBorder(),
                  ),
                ],
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

  */
