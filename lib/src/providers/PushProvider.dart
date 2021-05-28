import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushProvider
{
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _notificationStreamController = StreamController<String>.broadcast();
  Stream<String> get messages => _notificationStreamController.stream;

  initNotifications()
  {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print("=== TOKEN ===");
      //Token para firebase
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> info) async
      {
        print("==Message ==");
        print(info);
        String argumento = "no-data";
        if(Platform.isAndroid)
        {
          argumento = info["data"]["comida"] ?? "no-data";
        }
        _notificationStreamController.sink.add(argumento);
      },
      onLaunch: (Map<String, dynamic> info) async
      {
        print("=== On Launch ==");
      },
      onResume: (Map<String, dynamic> info) async
      {
        print("=== On Resume ==");
        final notify = info["data"]["comida"];
       _notificationStreamController.sink.add(notify);
      }
    );
  }

  dispose()
  {
    _notificationStreamController?.close();
  }
}