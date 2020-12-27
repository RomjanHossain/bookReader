import 'dart:convert';
import 'package:epub_viewer/epub_viewer.dart';
import '../saveBook/savebook.dart';

class ReadFromDB {
  //! first you have to save the book
  //? save the book on chache
  //? save the book on memory
  //! then you have to read the book!!!
  openBook(String url, String bookid) async {
    List locators = await LocatorDB().getLocator(bookid);
    EpubViewer.setConfig(
      identifier: "Book",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      nightMode: true,
    );

    EpubViewer.open(
      '$url',
      lastLocation:
          locators.isNotEmpty ? EpubLocator.fromJson(locators[0]) : null,
    );
    // get current locator
    EpubViewer.locatorStream.listen((event) async {
      // Get locator here
      Map json = jsonDecode(event);
      json['bookId'] = bookid;
      // Save locator to your database
      await LocatorDB().update(json);
    });
  }
}
