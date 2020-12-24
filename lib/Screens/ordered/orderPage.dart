import 'package:flutter/material.dart';
import 'package:knowyourbook/services/firebase/database.dart';
import 'package:knowyourbook/services/firebase/storage.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  static const String id = 'order';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Ordered',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: ListView(
          children: [
            Text(
              '\nEmpty',
              textAlign: TextAlign.center,
            ),
            FlatButton.icon(
              color: Colors.green,
              onPressed: () async {
                print('hu');
                await Provider.of<FirebaseStorageService>(context,
                        listen: false)
                    .listExample();
              },
              icon: Icon(Icons.home),
              label: Text('get all Dir+file'),
            ),
            FlatButton.icon(
              color: Colors.green,
              onPressed: () async {
                await Provider.of<DatabaseService>(context, listen: false)
                    .newBook();
              },
              icon: Icon(Icons.settings),
              label: Text('account counts'),
            ),
            FlatButton.icon(
              color: Colors.green,
              onPressed: () {
                print('hu');
              },
              icon: Icon(Icons.home),
              label: Text('holy'),
            ),
            FlatButton.icon(
              color: Colors.green,
              onPressed: () {
                print('hu');
              },
              icon: Icon(Icons.home),
              label: Text('holy'),
            )
          ],
        ));
  }
}
