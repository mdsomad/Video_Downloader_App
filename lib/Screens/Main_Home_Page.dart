

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Provider/main_home_page_provider.dart/MainHomePage_Provider.dart';
import 'package:video_downloader_application/Screens/displayoverotherapps/Display_over_other_Apps.dart';
import 'package:video_downloader_application/Screens/download/Download_Dio_Page.dart';
import 'package:video_downloader_application/Screens/download/Download_Page.dart';
import 'package:video_downloader_application/Screens/home/Home_Page.dart';
import 'package:video_downloader_application/Screens/playlist/PalyList_Page.dart';
import 'package:video_downloader_application/Video_DownladFiles/flutter_dowloadScreen.dart';
import 'package:video_downloader_application/Video_DownladFiles/testdownload.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';
import 'package:video_downloader_application/res/assets/image_asset.dart';




class MainHomePage extends StatefulWidget {
   MainHomePage({Key? key}) : super(key: key);




  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DownloadDioPage(),
    Center(child: Placeholder()),
  ];


  @override
  Widget build(BuildContext context) {
    return Consumer<MainHomePageProvider>(
      builder:(context, providerValues, child) {
      
    return Scaffold(
          
        body: _widgetOptions.elementAt(providerValues.currentIndex),
      
        bottomNavigationBar: BottomNavigationBar(
            // <-- BottomNavigationBar Using Example
            type: BottomNavigationBarType.fixed,
            currentIndex: providerValues.currentIndex,
            backgroundColor: AppColor.cardColor,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.pink,
            showSelectedLabels: false, // <-- HERE
            showUnselectedLabels: false, // <-- AND HERE
            // selectedLabelStyle: textTheme.caption,
            // unselectedLabelStyle: textTheme.caption,
            onTap: (val) {
             providerValues.setCurrentIndex(val);
            },
            items: [
              BottomNavigationBarItem(
                label: "",
                activeIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
              ),
              BottomNavigationBarItem(
                label: "",
                activeIcon: Image.asset(ImageAssets.bottomNavigationBarDownlaodLogo,color: Colors.pink),
                icon: Image.asset(ImageAssets.bottomNavigationBarDownlaodLogo),
              ),
              BottomNavigationBarItem(
                label: "",
                activeIcon: Image.asset(ImageAssets.bottomNavigationBarPlayListsLogo,color: Colors.pink,),
                icon: Image.asset(ImageAssets.bottomNavigationBarPlayListsLogo),
              ),
            ]),
      
    );

    },);
    
    
    
    
  }
}