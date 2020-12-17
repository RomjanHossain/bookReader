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

  //? 2. upload file
  Future<String> uploadFile(File file, User user) async {
    String _randomName = getRandomString(10);
    try {
      await storage.ref('${user.uid}/$_randomName.epub').putFile(file);
    } catch (e) {
      print('error for firebase storage $e');
    }
    return _randomName;
  }

  //? get all the dir+file name
  Future<void> listExample() async {
    // firebase_storage.ListResult result = await storage.ref().ge();
  }
}
