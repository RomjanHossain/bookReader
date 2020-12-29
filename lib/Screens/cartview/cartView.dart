import 'package:flutter/material.dart';

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
              children: [
                Text('lkjfskd'),
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

class RadioListButtonLOL extends StatefulWidget {
//  RadioListButtonLOL({this.});

  @override
  _RadioListButtonLOLState createState() => _RadioListButtonLOLState();
}

class _RadioListButtonLOLState extends State<RadioListButtonLOL> {
  bool _isActive = false;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text('add order contains as GIFT'),
      value: _isActive,
      onChanged: (bool v) {
        setState(() => _isActive = v);
      },
    );
    // return RadioListTile(
    //     title: Text('fukc yourself'),
    //     value: _isActive,
    //     groupValue: _isActive,
    //     onChanged: (bool v) {
    //       setState(() => _isActive = v);
    //     });
  }
}
