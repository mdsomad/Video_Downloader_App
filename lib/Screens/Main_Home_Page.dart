

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
import 'package:video_downloader_application/Video_DownladFiles/downloadload_file.dart';
import 'package:video_downloader_application/Video_DownladFiles/file_list.dart';
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
    // DisplayOverOtherAppsScreen(),
    Center(child: Placeholder()),
    // DownloadPage2(filterVideosList: null, videoList: null,),
  //  DownloadingDialog(url:"https://scontent-fco2-1.cdninstagram.com/o1/v/t16/f1/m82/5A4C8D7602A52F2139A553CCB4768990_video_dashinit.mp4?efg=eyJ2ZW5jb2RlX3RhZyI6InZ0c192b2RfdXJsZ2VuLjcyMC5jbGlwcyJ9&_nc_ht=scontent-fco2-1.cdninstagram.com&_nc_cat=109&vs=525964556234894_3597162966&_nc_vs=HBksFQIYT2lnX3hwdl9yZWVsc19wZXJtYW5lbnRfcHJvZC81QTRDOEQ3NjAyQTUyRjIxMzlBNTUzQ0NCNDc2ODk5MF92aWRlb19kYXNoaW5pdC5tcDQVAALIAQAVABgkR0JOX3BoUkZJUjVMN1dVREFQX2JDWV9oUWM5QmJxX0VBQUFGFQICyAEAKAAYABsBiAd1c2Vfb2lsATEVAAAmwpDd8ZiLhEAVAigCQzMsF0BGhR64UeuFGBJkYXNoX2Jhc2VsaW5lXzFfdjERAHUAAA%3D%3D&ccb=9-4&oh=00_AfBVdddcEnEb3pagmTOwR-lgQ9AzOiAjkSEto4zdIuV_9A&oe=646A3ADB&_nc_sid=c07a80&_nc_rid=4c624bc2a4"),
    // FlutterScreen(),
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