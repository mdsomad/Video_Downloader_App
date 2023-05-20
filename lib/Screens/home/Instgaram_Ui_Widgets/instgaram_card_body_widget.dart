import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/Instagram_reel/instagram_reel_model.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';
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
  //* Video List Filter
  // List? filterVideosList = videoList.data!.response!.videos?.where(((element) => element.hasAudio == true )).toList();
  
 //* List Reversed
  // filterVideosList = new List.from(filterVideosList!.reversed);

  //* Audios List Filter
 //  audios = audios.where(((element) => element.audioFormat == "mp4" )).toList();
    
    return Container(
  // height: 500,
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
        // height: 150,
        
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
              //  provider.downloadFile(filterVideosList![index].url.toString(),videoList.data!.response!.title.toString(),filterVideosList[index].quality.toString(),false,context);
              // Navigator.push(context, MaterialPageRoute(builder: ((context) => DownloadPage2(filterVideosList:filterVideosList![index],videoList:videoList,))));

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