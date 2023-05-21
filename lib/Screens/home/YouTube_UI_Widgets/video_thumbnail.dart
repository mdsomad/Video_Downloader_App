import 'package:flutter/material.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';






class VideoThumbnailWidget  extends StatelessWidget {
  final ApiResponse<VideoModel> videoList;
  VideoThumbnailWidget ({super.key, required this.videoList});



String numberFormat(int n) {
  String num = n.toString();
  int len = num.length;

  if (n >= 1000 && n < 1000000) {
    return num.substring(0, len - 3) + '.' + num.substring(len - 3, 1 + (len - 3)) + ' K';
  } else if (n >= 1000000 && n < 1000000000) {
    return num.substring(0, len - 6) + '.' + num.substring(len - 6, 1 + (len - 6)) + ' M';
  } else if (n > 1000000000) {
    return num.substring(0, len - 9) + '.' + num.substring(len - 9, 1 + (len - 9)) + ' B';
  } else {
    return num.toString();
  }
}
  



  

  @override
  Widget build(BuildContext context) {
    return Container(
    // color: Colors.yellow,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(top: 15,left: 20,bottom: 25),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80,
          width: 130,
          // margin: EdgeInsets.only(top: 30,left: 24,bottom: 25),
          color:AppColor.bodyColor,
          child: Image.network(
            videoList.data!.response!.thumbnails![0].url.toString(),
            fit: BoxFit.cover,
            ),
        ),

         const SizedBox(width: 15,),

        Container(
        // height: 80,
        width: MediaQuery.of(context).size.width/2.2,

        // color: Colors.pink,
        // margin: EdgeInsets.only(top: 45,left: 20,bottom: 10,),
        // padding: EdgeInsets.only(left: 15,),
          // color: Colors.pink,
          child: ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(
                videoList.data!.response!.title!.length > 36
                              ? "${videoList.data!.response!.title!.substring(0,36)}..."
                              : videoList.data!.response!.title!,
                style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
          
              const SizedBox(
                height: 10,
               ),
          
          
              // Text(
          
              //    videoList[0].videoUrl.length > 10
              //                 ? "${videoList[0].videoUrl.substring(0,23)} ..."
              //                 : videoList[0].videoUrl
                
              // ,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
          
              // SizedBox(height: 2,),
          
              Text( videoList.data!.response!.channelName!.length > 20
                              ? "${videoList.data!.response!.channelName!.substring(0,20)}..."
                              : videoList.data!.response!.channelName!

                  // "${videoList.channelName}"
                  
                  ,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
          
               
              SizedBox(
                height: 5,
              ),
              
              
              Text("${numberFormat(int.parse(videoList.data!.response!.viewCount.toString()))}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          
            
            ],
          ),
        )
      ],
    ),
  );





  
  }
}