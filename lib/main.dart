import 'package:flutter/material.dart';
import 'package:knowyourbook/Screens/BookView/bookView.dart';
import 'package:knowyourbook/Screens/homeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
        ),
      ),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        BookView.id: (context) => BookView(),
      },
    );
  }
}
