// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';
import 'package:video_downloader_application/Provider/download/Download_Dio_provider.dart';
import 'package:video_downloader_application/Screens/download/Widgets/videoText_widget.dart';
import 'package:video_downloader_application/Screens/download/Widgets/video_download_display_widget.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';





class DownloadDioPage extends StatefulWidget {
//   var filterVideosList;
//  ApiResponse<VideoModel> videoList;
//    DownloadDioPage({
//     Key? key,
//     required this.filterVideosList,
//     required this.videoList,
//   }) : super(key: key);

  @override
  State<DownloadDioPage> createState() => _DownloadDioPageState();
}

class _DownloadDioPageState extends State<DownloadDioPage> {


  @override
  void initState() {
    // TODO: implement initState
      Provider.of<DownloadProvider>(context,listen:false).checkFileExit();
      super.initState();
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          elevation: 7,
          // title: Container(
          //     // color: Colors.yellow,
          //     padding: EdgeInsets.only(bottom: 15),
          //     child: Image.asset("Assets/AppIcons/Frame.png")),
          // toolbarHeight: 30,


        ),
        body:Consumer<DownloadProvider>(  //* <-- Provider Use
        builder: (context, provider, child) {
        return provider.videoSaveList.isNotEmpty ? Center(
          child: Column(
            children: [
              VideoTextWidget(title:provider.videoSaveList[0].type_Of_File.toString(),),

              VideoDownloadDisplayWidget(thumbnails: provider.videoSaveList[0].thumbnails.toString(), title:provider.videoSaveList[0].title.toString(), press: () { 

                 provider.fileExist && provider.downloading == false 
                 ? provider.openfile()
                 : provider.startDownloading(url:provider.videoSaveList[0].videourl.toString(),title:  provider.videoSaveList[0].title.toString(),quality:  provider.videoSaveList[0].videoquality.toString(),type_Of_File: provider.videoSaveList[0].type_Of_File.toString(),);
                
               },),
            
              
              
              
        
              
              
              // context),
              // audioText(context),
             
              // Text("Downlad Screen",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:AppColors.white)),
            ],
          ),
        ) : SizedBox();

        
        
        
        
        
      //    ValueListenableBuilder<Box<VideoDownloadModel>>(
      //     valueListenable:  Boxes.getData().listenable(),
      //    builder:(context, boxValue, _) {

      //     var data = boxValue.values.toList().cast<VideoDownloadModel>();
          
          
          
      //     return data.isNotEmpty ? Center(
      //     child: Column(
      //       children: [
      //         VideoTextWidget(),

      //         VideoDownloadDisplayWidget(provider: provider,thumbnails: data[0].thumbnails, title:data[0].title, press: () { 

      //            provider.fileExist && provider.downloading == false 
      //            ? provider.openfile()
      //            : provider.startDownloading(data[0].videourl,data[0].title,data[0].videoquality,context);
                
      //          },),
            
              
              
              
        
              
              
      //         // context),
      //         // audioText(context),
             
      //         // Text("Downlad Screen",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:AppColors.white)),
      //       ],
      //     ),
      //   ) : SizedBox();
      //   },
      // )
        
        
        
        
        
 
        })

    );
  }
}