import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:video_downloader_application/Data/response/status.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';
import 'package:video_downloader_application/Provider/Settings/Settings_provider.dart';
import 'package:video_downloader_application/Provider/download/FlutterDownloader_provider.dart';
import 'package:video_downloader_application/Provider/home/home_provider.dart';
import 'package:video_downloader_application/Animation/Loading_Animation.dart';
import 'package:video_downloader_application/Screens/home/Instgaram_Ui_Widgets/instgaram_card_body_widget.dart';
import 'package:video_downloader_application/Screens/home/SideMenuBar/SideMenuBar.dart';
import 'package:video_downloader_application/Screens/home/YouTube_UI_Widgets/card_body_widget.dart';
import 'package:video_downloader_application/Screens/home/YouTube_UI_Widgets/input_search_widget.dart';
import 'package:video_downloader_application/Screens/home/home_Error_Widgets/home_status_error_widget.dart';
import 'package:video_downloader_application/Services/user_preference.dart';
import 'package:video_downloader_application/Utils/Utils.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';
import 'package:video_downloader_application/res/Components/internet_exceptions_widget.dart';
import 'package:video_downloader_application/res/assets/image_asset.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:flutter_downloader/flutter_downloader.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
FlutterInsta flutterInsta = FlutterInsta();








  int progress = 0;
  ReceivePort receivePort = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    var settingsProvider = Provider.of<SettingsProvider>(context,listen:false);
    settingsProvider.getSeveDownloading();  //* <-- SettingsProvider Class ka getSeveDownloading Function Call Raha hai
    
    
    
    
    
    IsolateNameServer.registerPortWithName(receivePort.sendPort, 'downloadingvideo');

    receivePort.listen((data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];

      setState(() {
        progress = data[2];
      });

      if (status == DownloadTaskStatus.complete) {
        print("Download complete");
        Utils.toastMessage("Downloaded Complete", true);
        setState(() {
          
        });
      }

      Utils.toastMessage(progress.toString(), false);
      print("progress Value this --> $progress");
    });

    FlutterDownloader.registerCallback(downloadCallback);








     final homeProviderModel = Provider.of<HomePageProvider>(context,listen: false);
     homeProviderModel.ReceiveSharingIntentFunction();              //* <-- Call This ReceiveSharingIntentFunction Function
    
    
    
  }






  static downloadCallback(id, status, progress) {
    final SendPort? receivePort = IsolateNameServer.lookupPortByName('downloadingvideo');
    receivePort!.send([id, status, progress]);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloadingvideo');
   // videoLinkController.dispose();
    super.dispose();
  }











String? username, followers = " ", following, bio, website, profileimage;
 void downloadReels() async {
    var s = await flutterInsta.downloadReels("https://www.instagram.com/reel/CsJDjgppsdL/?utm_source=ig_web_copy_link&igshid=MzRlODBiNWFlZA==");
     var s1 = await flutterInsta.getProfileData("md_somad");
    print(s);
    setState(() {
      this.username = flutterInsta.username; //username
      this.followers = flutterInsta.followers; //number of followers
      this.following = flutterInsta.following; // number of following
      this.website = flutterInsta.website; // bio link
      this.bio = flutterInsta.bio; // Bio
      this.profileimage = flutterInsta.imgurl; // Profile picture URL
      print(bio);
    });
   
  }







  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.bodyColor,

        endDrawerEnableOpenDragGesture: true,
        key: _drawerKey,
        drawer: SideMenu(),
        
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          automaticallyImplyLeading: false,
          elevation: 7,
          title: InkWell(
            onTap: (){
               _drawerKey.currentState!.openDrawer();
            },
            child: Container(
                // color: Colors.yellow,
                padding: EdgeInsets.only(bottom: 15),
                child: Image.asset(ImageAssets.homePageAppBarMenuLogo)),
          ),
          // toolbarHeight: 30,

          actions: [
            Container(
                // color: Colors.yellow,
                padding: EdgeInsets.only(bottom: 15),
                child: Image.asset(ImageAssets.homePageAppBarYoutubeLogo)),
          ],
        ),



        
        body: SafeArea(
          
          //* singlechildscrollview scrolls effect disabled
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
             return false;
            },
            
            child: SingleChildScrollView(
               physics: ClampingScrollPhysics(),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Consumer<HomePageProvider>(//* <-- Provider Use
                          builder: (context, provider, child) {
                        return InputSearchWidget(
                          controller: provider.videoLinkController,
                          onClearPreass: () {
                           provider.videoLinkController.clear();
                            provider.setcontrollerValueChack("");
                          },
                          controllerValueChack: provider.controllerValueChack,
                          onPreass: () {
                            if (provider.videoLinkController.text.isEmpty) {
                              Utils.ftushBarErrorMessage("Please Enter A Youtube Link", context);
                            } else {
                              //  downloadReels();
                              provider.checkVideoPlatformThenApiCall(provider.videoLinkController.text.toString().trim());
                              FocusScope.of(context).unfocus();

                            }
                          },
                        );
                      }),
          
          
          
                      const SizedBox(
                        height: 40,
                      ),
          
          
          
          
                       //* <-- Provider Use
                      Consumer<HomePageProvider>(builder: (context, provider, child) {
          
                        var data;
                        if (provider.checkVideoPlatformLink == "instagram") {
                          data = provider.instagramVideo;
                        } else {
                          data = provider.videoList;
                        }
          
                        switch (data.status) {
          
                          case Status.ISEMPTY:
                            return Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Center(
                                    child: Text(data.nodata.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold))));
          
                          case Status.LOADING:
                            return Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.green,
                                )));
          
                          // ! LoadingAnimation();
          
                          case Status.ERROR:
          
                            return HomeStatusErrorWidget(errorData: data, provider: provider, videoLinkController:provider.videoLinkController,);
          
                          case Status.COMPLETED:
          
                            if (provider.checkVideoPlatformLink == "instagram") {
                              return InstagramCardBodyWidget(
                                videoList: provider.instagramVideo,
                                provider: provider,
                              );
          
                            } else {
          
                              return CardBodyWidget(
                                videoList: provider.videoList,
                                provider: provider,
                              );
          
                              
                            }
          
                          default:
                            return Text("NO Data");
                        }
                      }),
                    ],
                  ),
          
          
          
          
          
          
                  Consumer<HomePageProvider>(//* <-- Provider Use
                      builder: (context, provider, child) {
                       return provider.isDataLoaded
                        ? Positioned(
                            top: 170,
                            left: 45,
                            child: const Text(
                              "DOWNLOAD",
                              style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                        : SizedBox();
                  }),
                ],
              ),
            ),
          ),
        ));
  }
}
