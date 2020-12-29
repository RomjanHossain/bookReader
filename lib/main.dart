import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:knowyourbook/Screens/BookView/bookView.dart';
import 'package:knowyourbook/Screens/cartview/cartView.dart';
import 'package:knowyourbook/Screens/homeScreen.dart';
import 'package:knowyourbook/Screens/ordered/orderPage.dart';
import 'package:knowyourbook/Screens/upload/uploadForm.dart';
import 'package:knowyourbook/Screens/upload/uploadPage.dart';
import 'package:knowyourbook/services/firebase/auth.dart';
import 'package:knowyourbook/services/firebase/database.dart';
import 'package:knowyourbook/services/firebase/storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: AuthServices().user),
        Provider(create: (context) => AuthServices()),
        Provider(create: (context) => FirebaseStorageService()),
        Provider(create: (context) => DatabaseService()),
      ],
      child: MaterialApp(
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
          UpLoadPage.id: (context) => UpLoadPage(),
          OrderPage.id: (context) => OrderPage(),
          RealUpPage.id: (context) => RealUpPage(),
          CheckOutPage.id: (context) => CheckOutPage(),
        },
      ),
    );
  }
}
