import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
// fi92GFXt0Jk:APA91bEhcHb6bmr352CzuWYcxCZNS5keX88SL4Cu4kq3A4zqDrn7lpkYPCP184wkzSqLIyG6DjRNmKek-aEDkLFJKa7VIOquVECGf4jTzNM2mQJHZaRh55pEVBAMEU6FdntCSDdSHVpf
class PushNotificationProvider {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _messageStreamController = StreamController<String>.broadcast();
  
  
  Stream<String> get messageStream => _messageStreamController.stream;

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
  // Or do other work.
  }

  initNotifications() async {

    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();

    print('FCM token: $token');

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print('======== onMessage ========');
    final argumento = message['data']['comida'] ?? 'no-data';
    _messageStreamController.sink.add(argumento);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print('======== onLaunch ========');
    final argumento = message['data']['comida'] ?? 'no-data';
    _messageStreamController.sink.add(argumento);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    final argumento = message['data']['comida'] ?? 'no-data';
    _messageStreamController.sink.add(argumento);
  }

  dispose() {
    _messageStreamController?.close();
  }

}