import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Data/response/status.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';
import 'package:video_downloader_application/Provider/FlutterDownloader_provider.dart';
import 'package:video_downloader_application/Provider/home_provider.dart';
import 'package:video_downloader_application/Animation/Loading_Animation.dart';
import 'package:video_downloader_application/Screens/home/Widgets/card_body_widget.dart';
import 'package:video_downloader_application/Screens/home/Widgets/input_search_widget.dart';
import 'package:video_downloader_application/Utils/Utils.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';
import 'package:video_downloader_application/res/Components/internet_exceptions_widget.dart';
import 'package:video_downloader_application/res/assets/image_asset.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController videoLinkController = TextEditingController();

  int progress = 0;
  ReceivePort receivePort = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, 'downloadingvideo');

    receivePort.listen((data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];

      setState(() {
        progress = data[2];
      });

      if (status == DownloadTaskStatus.complete) {
        print("Download complete");
        Utils.toastMessage("Downloaded Complete", true);
      }

      Utils.toastMessage(progress.toString(), false);
      print("progress Value this --> $progress");
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static downloadCallback(id, status, progress) {
    final SendPort? receivePort =
        IsolateNameServer.lookupPortByName('downloadingvideo');
    receivePort!.send([id, status, progress]);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloadingvideo');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.bodyColor,
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          elevation: 7,
          title: Container(
              // color: Colors.yellow,
              padding: EdgeInsets.only(bottom: 15),
              child: Image.asset(ImageAssets.homePageAppBarMenuLogo)),
          // toolbarHeight: 30,

          actions: [
            Container(
                // color: Colors.yellow,
                padding: EdgeInsets.only(bottom: 15),
                child: Image.asset(ImageAssets.homePageAppBarYoutubeLogo)),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Consumer<HomeProviderModel>(//* <-- Provider Use
                        builder: (context, provider, child) {
                      return InputSearchWidget(
                        controller: videoLinkController,
                        onClearPreass: () {
                          videoLinkController.clear();
                          provider.setcontrollerValueChack("");
                        },
                        controllerValueChack: provider.controllerValueChack,
                        onPreass: () {
                          if (videoLinkController.text.isEmpty) {
                            Utils.ftushBarErrorMessage(
                                "Please Enter A Youtube Link", context);
                          } else {
                            provider
                                .fatchVideoListApi(videoLinkController.text);
                            FocusScope.of(context).unfocus();
                            // Provider.of<HomeProviderModel>(context,listen: false).fatchVideoListApi(videoLinkController.text);
                          }
                        },
                      );
                    }),
                    const SizedBox(
                      height: 40,
                    ),
                    Consumer<HomeProviderModel>(//* <-- Provider Use
                        builder: (context, provider, child) {
                      switch (provider.videoList.status) {
                        case Status.ISEMPTY:
                          return Container(
                              height: MediaQuery.of(context).size.height / 2,
                              child: Center(
                                  child: Text(
                                      provider.videoList.nodata.toString(),
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

                        //  LoadingAnimation();

                        case Status.ERROR:
                          if (provider.videoList.message.toString() ==
                              "No Internet Conncetion") {
                            return InternetEexceptionWidget(onPress: () {
                              provider
                                  .fatchVideoListApi(videoLinkController.text);
                            });
                          } else {
                            return InkWell(
                                onTap: (() {
                                  provider.fatchVideoListApi(
                                      videoLinkController.text);
                                }),
                                child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    child: Center(
                                        child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment.center,
                                            child: Text(
                                                provider.videoList.message
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold))))));
                          }

                        case Status.COMPLETED:
                          return Stack(
                            children: [
                              //  Text('${provider.videoList.data?.response?.title.toString()}')
                              CardBodyWidget(
                                videoList: provider.videoList,
                                provider: provider,
                              )
                            ],
                          );

                        default:
                          return Text("NO Data");
                      }
                    }),
                  ],
                ),


                
                Consumer<HomeProviderModel>(//* <-- Provider Use
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
        ));
  }
}

//! currently Not Use

// class oldHomePage extends StatefulWidget {
//   const oldHomePage({Key? key}) : super(key: key);

//   @override
//   State<oldHomePage> createState() => _oldHomePageState();
// }

// class _oldHomePageState extends State<oldHomePage> {
//   TextEditingController videoLinkController = TextEditingController();

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     videoLinkController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Consumer<HomeProviderModel>(//* <-- Provider Use
//         builder: (context, provider, child) {
//       return Scaffold(
//         backgroundColor: AppColors.bodyColor,
//         appBar: AppBar(
//           backgroundColor: AppColors.appBarColor,
//           elevation: 7,
//           title: Container(
//               // color: Colors.yellow,
//               padding: EdgeInsets.only(bottom: 15),
//               child: Image.asset("Assets/AppIcons/Frame.png")),
//           // toolbarHeight: 30,

//           actions: [
//             Container(
//                 // color: Colors.yellow,
//                 padding: EdgeInsets.only(bottom: 15),
//                 child: Image.asset("Assets/AppIcons/youtube_logo.png")),
//           ],
//         ),
//         body: SafeArea(
//             child: SingleChildScrollView(
//           child: Stack(children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Haider(
//                   videoLinkController,
//                   () {
//                      if(videoLinkController.text.isEmpty){
//                         Utils.ftushBarErrorMessage("Please Enter A Youtube Link", context);
//                      }else{
//                         provider.fatchVideoListApi(videoLinkController.text);
//                      }
//                   },
//                   (){
//                        videoLinkController.clear();
//                        provider.setcontrollerValueChack("");
//                   },
//                   provider.controllerValueChack,
//                   context
//                 ),

//                 SizedBox(
//                   height: 40,
//                 ),

//                 //  Container(
//                 //   height: 300,
//                 //   width: 400,
//                 //    child: ListView.builder(
//                 //     shrinkWrap: true,
//                 //     itemCount: provider.videoList.length,
//                 //     itemBuilder:(context, index) {
//                 //       return
//                 //       CardBody(provider.videoList[index].thumbnails[0].url,provider.videoList[index].title,provider.videoList[index].channelName,context);
//                 //       // Text(provider.videoList[index].title);
//                 //    },),
//                 //  )

//                 //  provider.videoList.length > 0 ? CardBody(provider.videoList,context) : SingleChildScrollView()

//                 provider.loading ? LoadingAnimation()  : provider.videoList.length > 0

//                         ? CardBody(provider.videoList, context)

//                         : Container(
//                             height: MediaQuery.of(context).size.height / 2,
//                             child: const Center(
//                                 child: Text("Enter A Youtube Video Link",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold)
//                                     )
//                                )
//                           )

//                 //  provider.loading ? Container(
//                 //   height: MediaQuery.of(context).size.height /2,
//                 //   // color: Colors.pink,
//                 //   child: Center(child: CircularProgressIndicator(color:Colors.green,))): provider.videoList.length > 0 ? provider.loading ? Center(child: CircularProgressIndicator()) : CardBody(provider.videoList,context) : SizedBox()

//               ],
//             ),
//             provider.videoList.length > 0
//                 ? provider.loading
//                     ? const SizedBox()
//                     : const Positioned(
//                         top: 169,
//                         left: 45,
//                         child: const Text(
//                           "DOWNLOAD",
//                           style: TextStyle(
//                               fontSize: 21,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ))

//                 : const SizedBox(),

//           ]),

//         )

//       ),

//       );

//     });
//   }
// }

// // class HomeScreen2 extends StatefulWidget {

// //   const HomeScreen2({Key? key,}) : super(key: key);

// //   @override
// //   State<HomeScreen2> createState() => _HomeScreen2State();
// // }

// // class _HomeScreen2State extends State<HomeScreen2> {

// //  HomeViewViewModel homeViewViewModel = HomeViewViewModel();  //TODO Create object HomeViewViewModel with Provider Class

// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     homeViewViewModel.fatchMoviesListApi();   //* <-- This fatchMoviesListApi() Function Call
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final userPreferences = Provider.of<UserViewModel>(context);
// //      return Scaffold(
// //       appBar: AppBar(
// //         automaticallyImplyLeading: false,
// //         title: Text("Home Page"),
// //         actions: [
// //           InkWell(
// //             onTap: (){
// //               userPreferences.remove().then((value){             //* <-- User Token remove call
// //                  Navigator.pushNamed(context, RoutesName.login);
// //               });
// //             },
// //             child: Center(child: Text("Logout"),),
// //           ),
// //           SizedBox(width: 20,)
// //         ],
// //       ),
// //       body: ChangeNotifierProvider<HomeViewViewModel>(create: (context) => homeViewViewModel,
// //       child: Consumer<HomeViewViewModel>(builder: (context, value, child) {

// //         switch(value.moviesList.status){
// //           case Status.LOADING:
// //            return Center(child: CircularProgressIndicator());

// //           case Status.ERROR:
// //            return InkWell(
// //             onTap: (() {
// //               value.fatchMoviesListApi();
// //             }),
// //             child: Center(child:Text(value.moviesList.message.toString())));

// //           case Status.COMPLETED:

// //            return ListView.builder(
// //            itemCount: value.moviesList.data!.movies!.length,
// //             itemBuilder:(context, index) {

// //               return Text("");
// //            },);

// //          default:
// //          return Text("NO Data");

// //         }

// //         return Column(
// //         children: [

// //         ],
// //       );

// //       },),

// //       )
// //      );
// //   }
// // }
