import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/bg.jpg'),
              fit: BoxFit.cover,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/originals/62/04/3b/62043b0bb353f49600a23ed1b5ec922f.jpg'),
                  radius: 70,
                ),
                Text(
                  'Romjan D. Hossain',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // color: Colors.blue,
            child: ListView(
              children: [
                Text('Category'),
                ListTile(
                  leading: Icon(Icons.emoji_nature),
                  title: Text('Action and Adventure'),
                ),
                ListTile(
                  leading: Icon(Icons.home_filled),
                  title: Text('Classics'),
                ),
                ListTile(
                  leading: Icon(Icons.graphic_eq),
                  title: Text('Graphic Novel'),
                ),
                ListTile(
                  leading: Icon(Icons.emoji_nature),
                  title: Text('Detective and Mystery'),
                ),
                ListTile(
                  leading: Icon(Icons.emoji_nature),
                  title: Text('Fantasy'),
                ),
                ListTile(
                  leading: Icon(Icons.emoji_nature),
                  title: Text('historical Fiction'),
                ),
                ListTile(
                  leading: Icon(Icons.emoji_nature),
                  title: Text('Horror'),
                ),
                ListTile(
                  leading: Icon(Icons.emoji_nature),
                  title: Text('Literary Fiction'),
                ),
                ListTile(
                  leading: Icon(Icons.emoji_nature),
                  title: Text('PolyTechnic BD'),
                ),
                ListTile(
                  leading: Icon(Icons.emoji_nature),
                  title: Text('Romance'),
                ),
                ListTile(
                  leading: Icon(Icons.emoji_nature),
                  title: Text('Science Fiction'),
                ),
                ListTile(
                  leading: Icon(Icons.emoji_nature),
                  title: Text('Short Stories'),
                ),
                ListTile(
                  leading: Icon(Icons.emoji_nature),
                  title: Text('Suspense and Thrillers'),
                ),
                ListTile(
                  leading: Icon(Icons.emoji_nature),
                  title: Text("women's Fiction"),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.blue, spreadRadius: 2, blurRadius: 2.55)
            ], color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.share,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Tell a friend'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.help_outline_rounded,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Help and Feedback'),
                  ],
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ],
    );
  }
}
