import 'package:flutter/material.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';

class ProfileW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2,
            ),
            BoxShadow(
              color: Colors.blue,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: null,
              radius: 70,
            ),
            ListTile(
              title: Center(
                child: Text(
                  'Romjan D. Hossain',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              subtitle: Center(child: Text('romjan@gmail.com')),
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            ),
            Card(
              child: Text('My books'),
            ),
            Card(
              child: Text('Bookmarks'),
            ),
            Card(
              child: Text('dont know what to write'),
            ),
            MyBtn(
                onp: () {
                  print('pressed');
                },
                title: 'Log Out'),
          ],
        ),
      ),
    );
  }
}
