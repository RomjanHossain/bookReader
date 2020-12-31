import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/Models/book/bookmod.dart';
import 'package:knowyourbook/Screens/cartview/components/addgiftBtn.dart';
import 'package:knowyourbook/Screens/cartview/components/prost.dart';
import 'package:knowyourbook/services/firebase/database.dart';
import 'package:knowyourbook/services/providers/cart.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:provider/provider.dart';

class ShowListOfOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (BookModel _i in Provider.of<CartModel>(context).cartList)
            ProductStack(
              model: _i,
              price: _i.price,
              title: _i.name,
            ),
        ],
      ),
    );
  }
}

//? animation for crat page
Route cartRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CheckOutPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
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

class CheckOutPage extends StatefulWidget {
  static const String id = 'checkout';

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final _formKey = GlobalKey<FormState>();
  String _inD = 'in Dhaka';
  int _delFee = 60;
  void changeLoc() {
    if (_inD == 'in Dhaka') {
      setState(() {
        _inD = 'Not in Dhaka';
        _delFee = 80;
      });
    } else {
      setState(() {
        _inD = 'in Dhaka';
        _delFee = 60;
      });
    }
  }

  String _number, _address;
  final GlobalKey<ScaffoldState> _scaffoldKey2 = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context);
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      key: _scaffoldKey2,
      backgroundColor: Color(0xFFfaf8fb),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.navigate_before, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                (Provider.of<CartModel>(context).totalBook != 0)
                    ? ShowListOfOrder()

                    // Provider.of<CartModel>(context).cartList.forEach((element) =>ProductStack())
                    // ProductStack()
                    : Container(
                        height: 150,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              offset: Offset(-4, 4),
                              blurRadius: 5,
                              // spreadRadius: 3,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              offset: Offset(2, -2),
                              blurRadius: 5,
                              // spreadRadius: 3,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'No orders yet!',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('order'),
                      GestureDetector(
                        onTap: () {
                          addVoucher(context);
                        },
                        child: Text('add code'),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            'Order Summary',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Order'),
                            Text(
                                '৳${Provider.of<CartModel>(context).totalBookPrice}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Delivery ',
                                    ),
                                    TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(color: Colors.blue),
                                      text: _inD,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          changeLoc();
                                        },
                                    )
                                  ],
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                            ),
                            Text('৳$_delFee')
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Payment Method'),
                            Text('cash on delivery')
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total'),
                            Text(
                                '৳${_delFee + Provider.of<CartModel>(context).totalBookPrice}')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ExpansionTile(
                    title: Text('Address'),
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              onSaved: (txt) => _number = txt,
                              autocorrect: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'please enter your phone Number';
                                } else if (value.length < 11) {
                                  return 'number at least 11 charecter';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Your contact number',
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black38,
                                    )),
                                hintText: '+8801*********',
                              ),
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              onSaved: (txt) => _address = txt,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'please enter your address here';
                                }
                                return null;
                              },
                              autocorrect: false,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                labelText: 'Your Address here',
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              maxLines: 5,
                              textAlign: TextAlign.center,
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: RadioListButtonLOL(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 1.2,
                height: 60,
                child: Center(
                  child: RaisedButton(
                    color: Color(0xFF9680b6),
                    child: Text(
                      'Place Order',
                      style: TextStyle(color: Colors.white),
                    ),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      //! danger zone
                      if ((Provider.of<CartModel>(context, listen: false)
                              .totalBook ==
                          0)) {
                        _scaffoldKey2.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'You have no order!',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                      try {
                        if (_formKey.currentState.validate() &&
                            (Provider.of<CartModel>(context).totalBook != 0)) {
                          print('form validated');
                          String _randomID = getRandomString(10);
                          _user != null
                              ? Provider.of<DatabaseService>(context)
                                  .placeOrderUser(
                                  _user,
                                  Provider.of<CartModel>(context).bookidlists,
                                  _randomID,
                                  Provider.of<CartModel>(context).booknamelists,
                                  _address,
                                  _number,
                                  _delFee +
                                      Provider.of<CartModel>(context)
                                          .totalBookPrice,
                                  Provider.of<CartModel>(context, listen: false)
                                      .isGift,
                                )
                              : Provider.of<DatabaseService>(context)
                                  .placeOrderAnon(
                                  Provider.of<CartModel>(context).bookidlists,
                                  _randomID,
                                  Provider.of<CartModel>(context).booknamelists,
                                  _address,
                                  _number,
                                  _delFee +
                                      Provider.of<CartModel>(context)
                                          .totalBookPrice,
                                  Provider.of<CartModel>(context, listen: false)
                                      .isGift,
                                );
                        }
                      } catch (e) {
                        _scaffoldKey2.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'You have to fill your address',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }

                      // print('ordered');
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
