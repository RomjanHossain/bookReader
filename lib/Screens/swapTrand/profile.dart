import 'package:flutter/material.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:line_icons/line_icons.dart';

class ProfileW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 2,
            ),
            BoxShadow(
              color: Colors.blue,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/62/04/3b/62043b0bb353f49600a23ed1b5ec922f.jpg'),
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
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              ),
              Card(
                child: ListTile(
                  leading: Icon(LineIcons.book),
                  title: Text('My Book List'),
                  subtitle: Text('24'),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.bookmarks_rounded),
                  title: Text('Bookmarks'),
                  subtitle: Text('23'),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.upload_file),
                  title: Text('Uploaded'),
                  subtitle: Text('0'),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(LineIcons.cart_arrow_down),
                  title: Text('Ordered'),
                  subtitle: Text('0'),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              MyBtn(
                title: 'Log Out',
                swapActive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
