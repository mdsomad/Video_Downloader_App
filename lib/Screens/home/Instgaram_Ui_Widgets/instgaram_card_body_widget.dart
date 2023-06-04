import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/Instagram_reel/instagram_reel_model.dart';
import 'package:video_downloader_application/Models/download_details_store_model/download_details_store_model.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';
import 'package:video_downloader_application/Provider/Settings/Settings_provider.dart';
import 'package:video_downloader_application/Provider/download/Download_Dio_provider.dart';
import 'package:video_downloader_application/Provider/main_home_page_provider.dart/MainHomePage_Provider.dart';
import 'package:video_downloader_application/Screens/download/Download_Dio_Page.dart';
import 'package:video_downloader_application/Screens/home/Instgaram_Ui_Widgets/Instagram_Video_Thumbnail_Widget.dart';
import 'package:video_downloader_application/Screens/home/YouTube_UI_Widgets/video_thumbnail.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';





class InstagramCardBodyWidget extends StatelessWidget {
  final ApiResponse<InstagramReelModel> videoList;
  final dynamic provider;
  InstagramCardBodyWidget({super.key, required this.videoList, required this.provider});




// TODO suffixes low getFileSizeString Function
String getFileSizeString({required int bytes, int decimals = 0}) {
  const suffixes = ["B", "KB", "MB", "GB", "TB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
}





  // TODO suffixes High formatBytes Function
 String formatBytes(int bytes, int decimals) {
    if (bytes == 00) return "(?) MB";
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +' ' + suffixes[i];
  }
  
  



  

  
  @override
  Widget build(BuildContext context) {
    
    return Container(
   width: MediaQuery.of(context).size.width *.9,
   decoration: BoxDecoration(
     color: AppColor.cardColor,
     borderRadius: BorderRadius.circular(10),
     border: Border.all(color:AppColor.white,width: 1.5)
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      InstagramVideoThumbnailWidget(videoList: videoList,),
      Container(
        width: double.infinity,
        height: 21,
        color: Colors.blue,
        child: Row(
          children: [
           const SizedBox(width: 20,),
            Text("Video",style: TextStyle(color:AppColor.white,fontWeight: FontWeight.bold),),
          ],
        ),
      ),

      Container(
        child: ListView.builder(
          itemCount:1,
          shrinkWrap: true,
          itemBuilder:(context, index) {
          return  Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white54),
            )
          ),
          // color: Colors.yellow,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10,),
               Text(videoList.data!.response.video.width,style:TextStyle(color:AppColor.white)),
               Text(" x ",style:TextStyle(color:AppColor.white)),
               Text(videoList.data!.response.video.height,style:TextStyle(color:AppColor.white)),
              // Text(filterVideosList[index].fps.toString(),style:TextStyle(color:AppColor.white)),
              Text(" (mp4)" ,style:TextStyle(color:AppColor.white)),
              Spacer(),
              Text(
                //!getFileSizeString(bytes:int.parse(videos[index].contentLength))
                //* "300mb",
                "",
              
              style:TextStyle(color:AppColor.white)),

               TextButton(onPressed: (){


                 final String titleDate = DateTime.now().microsecondsSinceEpoch.toString();




                var settingsProvider = Provider.of<SettingsProvider>(context,listen:false);

                    
                    if(settingsProvider.downloading == true){
                       provider.downloadFile(videoList.data!.response.video.contentUrl.toString(),videoList.data!.response.video.name.toString(),videoList.data!.response.video.width.toString(),'mp4',context);
                    }else{

                    var downloadProvider = Provider.of<DownloadProvider>(context,listen:false);
                     
                    DownloadDetailsStoreModel downloadDetailsStoreModel = DownloadDetailsStoreModel(

                       videourl: videoList.data!.response.video.contentUrl.toString(),

                       title:videoList.data!.response.video.name.toString(),

                       thumbnails: videoList.data!.response.video.thumbnailUrl.toString(), 

                       videoquality:videoList.data!.response.video.width.toString(),

                       type_Of_File: 'mp4',

                      );




                    if(downloadProvider.videoSaveList.isNotEmpty){
                           if(kDebugMode){
                             print("List isNotEmpty");
                           }

                          downloadProvider.videoSaveList.clear();
                          downloadProvider.setVideoSaveList(downloadDetailsStoreModel);
                          Provider.of<DownloadProvider>(context,listen:false).startDownloading(url: videoList.data!.response.video.contentUrl.toString(),title: videoList.data!.response.video.name.toString() ,quality:  videoList.data!.response.video.width.toString(),type_Of_File: 'mp4',context: context);
                          Provider.of<MainHomePageProvider>(context,listen:false).setCurrentIndex(1);
                    }else{
                           
                        if(kDebugMode){
                             print("List isEmpty");
                         }
                         downloadProvider.setVideoSaveList(downloadDetailsStoreModel);
                         Provider.of<DownloadProvider>(context,listen:false).startDownloading(url: videoList.data!.response.video.contentUrl.toString(),title:videoList.data!.response.video.name.toString() ,quality:  videoList.data!.response.video.width.toString(),type_Of_File: 'mp4',context: context);
                         Provider.of<MainHomePageProvider>(context,listen:false).setCurrentIndex(1);
                    }
                         
                      print(downloadProvider.videoSaveList[0].videoquality);
                  

                    }
                
                
                
                // !provider.downloadFile(videoList.data!.response.video.contentUrl.toString(),videoList.data!.response.video.name.toString(),videoList.data!.response.video.width.toString(),false,context);
                
              }, 
              style: ButtonStyle(overlayColor:
                    MaterialStateColor.resolveWith((states) =>Colors.white.withOpacity(0.1)),
                    shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                           RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(100.0),
                    ))),
                    child:Icon(Icons.download,color:provider.downloading ? Colors.blue : AppColor.downloadIcon,size:18 ,))
      
      
   
           
          ],),
        );
        },),
      ),






     
      
    ],
  )
  );
    




  }
}