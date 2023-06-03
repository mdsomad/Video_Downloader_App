import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Provider/download/DownloadProvider.dart';
import 'package:video_downloader_application/Provider/download/FlutterDownloader_provider.dart';
import 'package:video_downloader_application/Provider/download/Download_Dio_provider.dart';
import 'package:video_downloader_application/Provider/home/home_provider.dart';
import 'package:video_downloader_application/Provider/main_home_page_provider.dart/MainHomePage_Provider.dart';
import 'package:video_downloader_application/Screens/home/Home_Page.dart';
import 'package:video_downloader_application/Animation/Loading_Animation.dart';
import 'package:video_downloader_application/Screens/Main_Home_Page.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:video_downloader_application/Services/user_preference.dart';

import 'Provider/Settings/Settings_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   
  //* Plugin must be initialized before using
  await FlutterDownloader.initialize(
    debug: true,       // optional: set to false to disable printing logs to console (default: true)
    ignoreSsl: true    // option: set to false to disable working with http links (default: false)
  );
  
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[

             ChangeNotifierProvider<HomePageProvider>(
              create:(context)=>HomePageProvider()
            ),
            
             ChangeNotifierProvider<DownloadProvider>(
              create:(context)=>DownloadProvider()
            ),
            
             ChangeNotifierProvider<FlutterDownloaderProvider>(
              create:(context)=>FlutterDownloaderProvider()
            ),
            
             ChangeNotifierProvider<MainHomePageProvider>(
              create:(context) => MainHomePageProvider()
            ),

             ChangeNotifierProvider<SettingsProvider>(
              create:(context) => SettingsProvider()
            ),
             ChangeNotifierProvider<DownloadProviderPress>(
              create:(context) => DownloadProviderPress()
            ),
            
    ],

    child:   MaterialApp(
      title: 'Neontube Downloader',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainHomePage(),
    ),
    
    );
    
    
    
    
 






  }
}







