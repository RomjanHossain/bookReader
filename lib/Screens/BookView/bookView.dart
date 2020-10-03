import 'package:flutter/material.dart';

class BookView extends StatefulWidget {
  static const String id = 'bookPage';
  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('book'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: Text('ksjadlkf')),
          Expanded(child: Text('ksjadlkf')),
          // Text('ksjadlkf'),
          // Text('ksjadlkf'),
        ],
      ),
    );
  }
}
