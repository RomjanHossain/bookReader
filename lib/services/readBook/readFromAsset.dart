import 'dart:convert';
import 'package:epub_viewer/epub_viewer.dart';

class ReadBookFromAsset {
  openBook(String loc) async {
    EpubViewer.setConfig(
        identifier: "Book",
        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
        allowSharing: true,
        enableTts: true,
        nightMode: true);

    await EpubViewer.openAsset(
      loc,
      lastLocation: EpubLocator.fromJson({
        "bookId": "2239",
        "href": "/OEBPS/ch06.xhtml",
        "created": 1539934158390,
        "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
      }),
    );
    // get current locator
    EpubViewer.locatorStream.listen((locator) {
      print('LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
    });
  }
}
