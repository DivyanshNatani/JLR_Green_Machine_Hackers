import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/screens/home.dart';
import '/screens/usage.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    // Future<void> res = requestPermission();
    // print(res.get());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

Future<void> requestPermission() async {
  final permission = Permission.camera;

  if (await permission.isDenied) {
    final result = await permission.request();

    if (result.isGranted) {
      // Permission is granted
    } else if (result.isDenied) {
      // Permission is denied
    } else if (result.isPermanentlyDenied) {
      // Permission is permanently denied
    }
  }
}

//
//
// Future<void> requestPermission() async {
//   final permission = Permission.location;
//
//   if (await permission.isDenied) {
//     await permission.request();
//   }
// }
//
// Future<bool> checkPermissionStatus() async {
//   final permission = Permission.location;
//
//   return await permission.status.isGranted;
// }
//
// Future<bool> shouldShowRequestRationale() async {
//   final permission = Permission.location;
//
//   return await permission.shouldShowRequestRationale;
// }
//
// Future<bool> checkPermanentlyDenied() async {
//   final permission = Permission.camera;
//
//   return await permission.status.isPermanentlyDenied;
// }
//
// void openSettings() {
//   openAppSettings();
// }