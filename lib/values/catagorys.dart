import 'package:flutter/material.dart';
import 'package:knowyourbook/values/const.dart';

class GetTitle extends StatelessWidget {
  GetTitle({
    this.type,
  });
  final BookCategory type;

  @override
  Widget build(BuildContext context) {
    return Text(getText());
  }

  // ignore: missing_return
  String getText() {
    switch (type) {
      case BookCategory.Action:
        return 'Action';
      case BookCategory.Adult:
        return 'Adult';
      case BookCategory.Adventure:
        return 'Adventure';
      case BookCategory.Biography:
        return 'Biography';
      case BookCategory.Classics:
        return 'Classics';
      case BookCategory.Cultural:
        return 'Cultural';
      case BookCategory.Detective:
        return 'Detective';
      case BookCategory.Fantasy:
        return 'Fantasy';
      case BookCategory.Feminism:
        return 'Feminism';
      case BookCategory.Historical:
        return 'Historical';
      case BookCategory.Horror:
        return 'Horror';
      case BookCategory.Literacy:
        return 'Literacy';
      case BookCategory.Mystery:
        return 'Mystery';
      case BookCategory.Novels:
        return 'Novels';
      case BookCategory.Philosophy:
        return 'Philosophy';
      case BookCategory.Poetry:
        return 'poetry';
      case BookCategory.Psychology:
        return 'Psychology';
      case BookCategory.Religion:
        return 'Religion';
      case BookCategory.Romance:
        return 'Romance';
      case BookCategory.Science:
        return 'Science';
      case BookCategory.ScienceFiction:
        return 'Science-Fiction';
      case BookCategory.Selfhelp:
        return 'Self-help';
      case BookCategory.Short:
        return 'Short';
      case BookCategory.Social:
        return 'Social';
      case BookCategory.Suspense:
        return 'Suspense';
      case BookCategory.Thrillers:
        return 'Thrillers';
      case BookCategory.Womens:
        return 'Womens';
    }
  }
}
