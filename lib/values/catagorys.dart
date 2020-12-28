import 'package:flutter/material.dart';
import 'package:knowyourbook/values/const.dart';

class CustomNavItem extends StatelessWidget {
  CustomNavItem({
    this.type,
  });
  final Category type;

  @override
  Widget build(BuildContext context) {
    return Text(getText());
  }

  // ignore: missing_return
  String getText() {
    switch (type) {
      case Category.Action:
        return 'Action';
      case Category.Adult:
        return 'Adult';
      case Category.Adventure:
        return 'Adventure';
      case Category.Biography:
        return 'Biography';
      case Category.Classics:
        return 'Classics';
      case Category.Cultural:
        return 'Cultural';
      case Category.Detective:
        return 'Detective';
      case Category.Fantasy:
        return 'Fantasy';
      case Category.Feminism:
        return 'Feminism';
      case Category.Historical:
        return 'Historical';
      case Category.Horror:
        return 'Horror';
      case Category.Literacy:
        return 'Literacy';
      case Category.Mystery:
        return 'Mystery';
      case Category.Novels:
        return 'Novels';
      case Category.Philosophy:
        return 'Philosophy';
      case Category.Poetry:
        return 'poetry';
      case Category.Psychology:
        return 'Psychology';
      case Category.Religion:
        return 'Religion';
      case Category.Romance:
        return 'Romance';
      case Category.Science:
        return 'Science';
      case Category.ScienceFiction:
        return 'Science-Fiction';
      case Category.Selfhelp:
        return 'Self-help';
      case Category.Short:
        return 'Short';
      case Category.Social:
        return 'SOcial';
      case Category.Suspense:
        return 'Suspense';
      case Category.Thrillers:
        return 'Thrillers';
      case Category.Womens:
        return 'Womens';
    }
  }
}
