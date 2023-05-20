import 'package:flutter/material.dart';
import 'package:video_downloader_application/Provider/home/home_provider.dart';
import 'package:video_downloader_application/res/Components/Show_Error_Message_Eexception_Widget.dart';
import 'package:video_downloader_application/res/Components/general_exception.dart';
import 'package:video_downloader_application/res/Components/internet_exceptions_widget.dart';

class HomeStatusErrorWidget extends StatelessWidget {
  final dynamic errorData;
  final dynamic provider;
  final TextEditingController videoLinkController;
  HomeStatusErrorWidget(
      {super.key,
      required this.errorData,
      required this.provider,
      required this.videoLinkController});

  @override
  Widget build(BuildContext context) {
    if (errorData.message.toString() == "No Internet Conncetion") {
      return InternetEexceptionWidget(onPress: () {
        provider.checkVideoPlatformThenApiCall(videoLinkController.text.toString().trim());
      });
    }else if(errorData.message.toString() == "Invaild request Please Enter A Youtube Link"){
      return  ShowErrorMessageEexceptionWidget(errorMessage: errorData.message, onPress: () { 
          provider.checkVideoPlatformThenApiCall(videoLinkController.text.toString().trim());
       },);
    }else if(errorData.message.toString() == "Please Enter A Valid Link"){
      return  ShowErrorMessageEexceptionWidget(errorMessage: errorData.message, onPress: () { 
          provider.checkVideoPlatformThenApiCall(videoLinkController.text.toString().trim());
       },);
    }else {
       return GeneralEexceptionWidget(onPress: () { 
                  provider.checkVideoPlatformThenApiCall(videoLinkController.text.toString().trim());
              },);









      
      // return InkWell(
      //     onTap: (() {
      //       provider.checkVideoPlatformThenApiCall(videoLinkController.text);
      //     }),
      //     child: Container(
      //         height: MediaQuery.of(context).size.height / 2,
      //         width: MediaQuery.of(context).size.width / 1.2,
      //         child: Center(
      //             child: FittedBox(
      //                 fit: BoxFit.scaleDown,
      //                 alignment: Alignment.center,
      //                 child: Text(
      //                     //!  provider.isInstagramVideo ? provider.instagramVideo.message.toString() :  provider.videoList.message.toString()
      //                     errorData.message.toString(),
      //                     style: TextStyle(
      //                         color: Colors.red,
      //                         fontSize: 25,
      //                         fontWeight: FontWeight.bold))))));




    }
  }
}
