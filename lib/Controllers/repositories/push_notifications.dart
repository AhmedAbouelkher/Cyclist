//! DIABLED

// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:get/get.dart';

// class PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging();

//   Future<String> getToken() async {
//     return await _fcm.getToken();
//   }

//   Future initialise() async {
//     if (Platform.isIOS) {
//       _fcm.requestNotificationPermissions(IosNotificationSettings());
//     }
//     _fcm.getToken().then((val) {});
//     _fcm.configure(
//       onMessage: (Map<String, dynamic> message) async {},
//       onLaunch: (Map<String, dynamic> message) async {},
//       onResume: (Map<String, dynamic> message) async {},
//     );
//   }
// }
