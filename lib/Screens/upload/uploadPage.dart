import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:knowyourbook/Screens/upload/uploadForm.dart';

enum tags { harder, smarter, selfStarter, tradingCharter }

class UpLoadPage extends StatelessWidget {
  static const String id = 'upload';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RealUpPage.id);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Upload',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Text(
              'Empty',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
