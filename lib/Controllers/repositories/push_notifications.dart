import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print(message);
}

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  PushNotificationService._();
  static PushNotificationService get instance => PushNotificationService._();

  Future<String> getToken() async {
    return _fcm.getToken();
  }

  Future<void> initialise() async {
    if (Platform.isIOS) _fcm.requestNotificationPermissions(IosNotificationSettings());
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print(message);
      },
    );
  }
}
