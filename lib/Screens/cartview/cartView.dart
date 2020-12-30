import 'package:flutter/material.dart';
import 'package:knowyourbook/Screens/cartview/components/addgiftBtn.dart';

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

class CheckOutPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  static const String id = 'checkout';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                ProductStack(),
                ProductStack(),
                ProductStack(),
                ProductStack(),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('order'), Text('add code')],
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
                          children: [Text('Order'), Text('৳70')],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Delivery'), Text('৳60')],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Total'), Text('৳130')],
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
                    // trailing: Text('shit'),
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              autocorrect: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
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
                              autocorrect: false,
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
                      print('ordered');
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

class ProductStack extends StatelessWidget {
  const ProductStack({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'images/pro.jpg',
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Longer Human By jfklsdjfsjfssdfs',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '৳60',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    AddRemoveItem(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Color(0xFFc5bcd1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class AddRemoveItem extends StatefulWidget {
  @override
  _AddRemoveItemState createState() => _AddRemoveItemState();
}

class _AddRemoveItemState extends State<AddRemoveItem> {
  int _item = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            print('removed');
            (_item > 1)
                ? setState(() {
                    _item -= 1;
                  })
                : setState(() {
                    _item = 1;
                  });
          },
        ),
        Text(_item.toString()),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _item += 1;
              });
            })
      ],
    );
  }
}
