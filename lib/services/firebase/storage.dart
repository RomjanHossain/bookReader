import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:knowyourbook/values/const.dart';

class FirebaseStorageService {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  //? 1. pick file from user
  Future<File> pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['epub'],
    );
    if (result != null) {
      File file = File(result.files.first.path);
      return file;
    } else {
      //! if User canceled the picker
      return null;
    }
  }

  //? 1. pick file from user
  Future<File> pickImageFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      File file = File(result.files.first.path);
      return file;
    } else {
      //! if User canceled the picker
      return null;
    }
  }

  //? 2. upload file
  Future<String> uploadFile(File file1, File file2, User user) async {
    String _randomName = getRandomString(20);
    try {
      await storage.ref('${user.uid}/$_randomName.epub').putFile(file1);
      await storage.ref('${user.uid}/$_randomName.jpg').putFile(file2);
    } catch (e) {
      print('error for firebase storage $e');
    }
    return _randomName;
  }

//? download url
  Future<String> epubdownloadURL(String uid, String name) async {
    String downloadURL = await storage.ref('$uid/$name.epub').getDownloadURL();
    return downloadURL;
  }

  Future<String> coverdownloadURL(String uid, String name) async {
    String downloadURL = await storage.ref('$uid/$name.jpg').getDownloadURL();
    return downloadURL;
  }

  //? get all the dir+file name
  Future<void> listExample() async {
    // firebase_storage.ListResult result = await storage.ref().ge();
  }
}
