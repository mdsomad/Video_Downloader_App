// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class DownloadProviderPress extends ChangeNotifier {
//   // var _progressList = <double>[];

//   var _progressList = 0.0;

//   double count = 0.0;

//   double currentProgress() {
//     //fetch the current progress,
//     //its in a list because we might want to download
//     // multiple files at the same time,
//     // so this makes sure the correct download progress
//     // is updated.
    
    
//     try {
//       return _progressList;
//     } catch (e) {
//       _progressList = 0.0;
//       return 0;
//     }
//   }

//   void download(int index) async {
//     print('index Value This --> $index');
//     NotificationService notificationService = NotificationService();

//     // final storageRef = FirebaseStorage.instance.ref().child(filePath);
//     // final downloadUrl = await storageRef.getDownloadURL();

//     // final fileName = storageRef.name;

//     final dio = Dio();
//       String url = 'https://rr2---sn-n4v7snee.googlevideo.com/videoplayback?expire=1685738372&ei=JP95ZIsEmKySBoOhsaAI&ip=3.101.57.97&id=o-AMhLXPwplp4KW2W3uU3K5lmdR8aIZdrUAbsg9WHNIknK&itag=136&aitags=133%2C134%2C135%2C136%2C160%2C242%2C243%2C244%2C247%2C278&source=youtube&requiressl=yes&mh=Kh&mm=31%2C29&mn=sn-n4v7snee%2Csn-o097znzk&ms=au%2Crdu&mv=u&mvi=2&pl=24&spc=qEK7B9H9onFuZ6HV3cwDfy5deqp3SnvC_M1mLyPRhw&vprv=1&svpuc=1&mime=video%2Fmp4&ns=8Smjtdy1OtwAQRsF04NNTk0N&gir=yes&clen=1589444&dur=7.899&lmt=1675099031430637&mt=1685715642&fvip=1&keepalive=yes&fexp=24007246%2C24362688&beids=24350018&c=WEB&txp=631A224&n=Xf_gQp8bSmYGzw&sparams=expire%2Cei%2Cip%2Cid%2Caitags%2Csource%2Crequiressl%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Cgir%2Cclen%2Cdur%2Clmt&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl&lsig=AG3C_xAwRQIhALGz8UYvr4mdXXiEE1Su2K2HXy2oHfDYeR0nxDQVsrPjAiAT6qK4j2U6CFON51WUr0jFUjxJgpXDtKCvg3Q9S0pzQw%3D%3D&sig=AOq0QJ8wRgIhAJcs_T4VHvv7TwSA2VhyIKBj-3exlJzuHMxz0v4g5H5UAiEAxtgWmT4Qlj9--f83iBBmfoh9JPsC1yrlb0Ki5NkdfIM%3D';
//     try {
//       dio.download(url,
//           "/storage/emulated/0/Download/12134.mp4",
//           onReceiveProgress: ((count, total) async {
//          await Future.delayed(const Duration(seconds: 1), () {

//           _progressList = (count / total);
//           notificationService.createNotification(
//               100, ((count / total) * 100).toInt(),index);
//           notifyListeners();

//         });

//       }));
//     } on DioError catch (e) {
//       print("error downloading file $e");
//     }
//   }
// }






// class NotificationService {
//   //* Hanle displaying of notifications.
//   static final NotificationService _notificationService = NotificationService._internal();
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   final AndroidInitializationSettings _androidInitializationSettings =const AndroidInitializationSettings('@mipmap/ic_launcher_foreground');

//   factory NotificationService() {
//     return _notificationService;
//   }

//   NotificationService._internal() {
//     init();
//   }

//   void init() async {
//     final InitializationSettings initializationSettings = InitializationSettings(
//         android: _androidInitializationSettings,
//     );
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (response) {
//          print('background app Notification Click Then Open ${response.payload.toString()}');
//     }
//     );
//   }

//   void createNotification(int count, int i, int id) {
//     //* show the notifications.
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'progress channel', 'progress channel',
//         channelDescription: 'progress channel description',
//         channelShowBadge: false,
//         importance: Importance.max,
//         priority: Priority.high,
//         onlyAlertOnce: true,
//         showProgress: true,
//         maxProgress: count,
//         progress: i);

//        var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

//     _flutterLocalNotificationsPlugin.show(id, 'progress notification title',
//         'progress notification body', platformChannelSpecifics,
//         payload: 'item x');
//   }
// }