import 'package:flutter/material.dart';

class UpLoadPage extends StatelessWidget {
  static const String id = 'upload';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('add btn clicked');
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
        body: Center(
          child: Text('Empty'),
        ));
  }
}
