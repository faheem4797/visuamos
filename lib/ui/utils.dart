import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visuamos/services/authService.dart';
import 'package:visuamos/ui/screens/login.dart';

void logoutAndPushLoginScreen(BuildContext context) {
  AuthService().signOut();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Login()),
      (Route<dynamic> route) => false);
}

Future<bool> requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}


//
//
//
//
//
//
// Directory directory;
//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getExternalStorageDirectory();
//         } else {
//           return false;
//         }
//       } else {
//         if (await _requestPermission(Permission.photos)) {
//           directory = await getApplicationDocumentsDirectory();
//         } else {
//           return false;
//         }
//       }

//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         File saveFile = File(directory.path + "/$fileName");
//         //await dio.download(url, saveFile.path,
//         //    onReceiveProgress: (value1, value2) {
//         //      setState(() {
//         //         progress = value1 / value2;
//         //        });
//         //     });
//         if (Platform.isIOS) {
//           await ImageGallerySaver.saveFile(saveFile.path,
//               isReturnPathOfIOS: true);
//         }
//         return true;
//       }
//     } catch (e) {
//       print(e);
//     }
//     return false;
//   }