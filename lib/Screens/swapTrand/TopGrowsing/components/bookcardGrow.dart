import 'package:flutter/material.dart';
import 'package:knowyourbook/Widgets/myBtn.dart';
import 'package:knowyourbook/values/const.dart';
import 'package:line_icons/line_icons.dart';

class BookCardGrowing extends StatelessWidget {
  BookCardGrowing(
      {this.index, this.desc, this.docID, this.name, this.readed, this.views});
  final int index;
  final String docID, name, views, readed, desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Text(
            '#${index + 1} ',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Expanded(
            child: Hero(
              tag: docID,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.network(
                  'https://i.pinimg.com/originals/62/04/3b/62043b0bb353f49600a23ed1b5ec922f.jpg',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    name,
                    style: kTitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    desc,
                    style: kSubtitle,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    KSmallBtn(
                      iconData: LineIcons.eye,
                      text: views,
                    ),
                    KSmallBtn(
                      iconData: LineIcons.book,
                      text: readed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
