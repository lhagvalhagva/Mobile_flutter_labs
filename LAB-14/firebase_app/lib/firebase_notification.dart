import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessage {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();
    final FCMtoken = await firebaseMessaging.getToken();
    debugPrint('FCMtoken: $FCMtoken');
    FirebaseMessaging.instance.getInitialMessage().then((message) => handleNotification(message!));
    FirebaseMessaging.onMessageOpenedApp.listen((message) => handleNotification(message));
  }

  void handleNotification(RemoteMessage message) {
    if (message.notification != null) return;
    debugPrint('title: ${message.notification?.title}');
    debugPrint('body: ${message.notification?.body}');
}
}