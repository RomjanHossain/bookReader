// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class DownloadFile {
//   final Dio dio = Dio();
//   bool loading = false;
//   double progress = 0;

//   //? save the file
//   Future<bool> saveEpub(String url, String fileName) async {
//     Directory directory;
//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getExternalStorageDirectory();
//           String newPath = "";
//           print(directory);
//           List<String> paths = directory.path.split("/");
//           for (int x = 1; x < paths.length; x++) {
//             String folder = paths[x];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               break;
//             }
//           }
//           newPath = newPath + "/RPSApp";
//           directory = Directory(newPath);
//         } else {
//           return false;
//         }
//       }
//       File saveFile = File(directory.path + "/$fileName");
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         await dio.download(url, saveFile.path,
//             onReceiveProgress: (value1, value2) {
//           setState(() {
//             progress = value1 / value2;
//           });
//         });

//         return true;
//       }
//       return false;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   //? handle permission
//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     }
//     return false;
//   }

//   //? download the file!!!
//   downloadFile() async {
//     setState(() {
//       loading = true;
//       progress = 0;
//     });
//     bool downloaded = await saveEpub(
//         "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
//         "video.mp4");
//     if (downloaded) {
//       print("File Downloaded");
//     } else {
//       print("Problem Downloading File");
//     }
//     setState(() {
//       loading = false;
//     });
//   }
// }
