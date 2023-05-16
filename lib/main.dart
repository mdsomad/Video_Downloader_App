import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Provider/FlutterDownloader_provider.dart';
import 'package:video_downloader_application/Provider/Download_Dio_provider.dart';
import 'package:video_downloader_application/Provider/home_provider.dart';
import 'package:video_downloader_application/Screens/home/Home_Page.dart';
import 'package:video_downloader_application/Animation/Loading_Animation.dart';
import 'package:video_downloader_application/Screens/Main_Home_Page.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
    debug: true, // optional: set to false to disable printing logs to console (default: true)
    ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[

             ChangeNotifierProvider<HomeProviderModel>(
              create:(context)=>HomeProviderModel()
            ),
            
             ChangeNotifierProvider<DownloadProvider>(
              create:(context)=>DownloadProvider()
            ),
            
             ChangeNotifierProvider<FlutterDownloaderProvider>(
              create:(context)=>FlutterDownloaderProvider()
            ),
            
    ],

    child:   MaterialApp(
      title: 'Video Downloader Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainHomePage(),
    ),
    
    );
    
    
    
    
 






  }
}
