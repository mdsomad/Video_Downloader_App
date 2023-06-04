import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file_plus/open_file_plus.dart';

class NotificationService {




  //* Hanle displaying of notifications.
  static final NotificationService _notificationService = NotificationService._internal();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
  DarwinInitializationSettings iosSettings = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestCriticalPermission: true,
    requestSoundPermission: true

  );

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal() {
    init();
  }



  void init() async {
    final InitializationSettings initializationSettings = InitializationSettings(
        android: _androidInitializationSettings,
        iOS: iosSettings
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
         OpenFile.open(response.payload.toString());
         if(kDebugMode){
           print('background app Notification Click Then Open ${response.payload.toString()}');
         }
    }
    );
  }



//TODO: Create showNotification function
void showNotification(String videoTitle,String videoPath)async{
    

    AndroidNotificationChannel channel = AndroidNotificationChannel(
       Random.secure().nextInt(100000).toString(),
      "High importance Notification",
      importance: Importance.max
   );


    AndroidNotificationDetails androidDetails = new AndroidNotificationDetails(
       channel.id.toString() ,
       channel.name.toString(),
       channelDescription: 'Successfully download',
       priority: Priority.max,
       importance: Importance.max,
       playSound:true
    );

    DarwinNotificationDetails iosDetails = new DarwinNotificationDetails(
         presentAlert: true,
         presentBadge: true,
         presentSound: true
    );


    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );


  //* Notifications Show Karne Ka pahla Tarika Yha hai
   await _flutterLocalNotificationsPlugin.show(0,videoTitle,"Download complete, click to check",
     notificationDetails,
     payload: videoPath
    );


}




}