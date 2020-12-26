import 'dart:convert';
import 'package:epub_viewer/epub_viewer.dart';

class ReadFromDB {
  //! first you have to save the book
  //? save the book on chache
  //? save the book on memory
  //! then you have to read the book!!!
  openBook(String url) async {
    EpubViewer.setConfig(
      identifier: "Book",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      nightMode: true,
    );

    EpubViewer.open(
      '$url',
      lastLocation: EpubLocator.fromJson(
        {
          "bookId": "2239",
          "href": "/OEBPS/ch06.xhtml",
          "created": 1539934158390,
          "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
        },
      ),
    );
    // get current locator
    EpubViewer.locatorStream.listen((locator) {
      print('LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
    });
  }
}
