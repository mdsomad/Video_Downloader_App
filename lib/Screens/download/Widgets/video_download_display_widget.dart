import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/Video_Model.dart';




class VideoDownloadDisplayWidget extends StatelessWidget {
  final dynamic provider;
  final dynamic filterVideosList;
  final ApiResponse<VideoModel> videoList;
  final VoidCallback press;
  VideoDownloadDisplayWidget({super.key, required this.provider, required this.filterVideosList, required this.videoList, required this.press});


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
    height: 100,
    width: MediaQuery.of(context).size.width,
    color: Colors.grey,
    child: Row(
      children: [
        Stack(
          children: [
        
            InkWell(
              onTap: (){
                  provider.fileExist &&  provider.downloading == false ?  provider.openfile():
                  provider.cancelDownlad();
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: 120,
                // color: Color(0xff4F4F4F),
                child: Image.network(
                videoList.data!.response!.thumbnails![0].url.toString(),
                fit: BoxFit.cover,
                ),
              ),
            ),

           provider.downloading ? Positioned(
              top: 25,
              left: 45,
                child:InkWell(
                   onTap: (){
                    provider.fileExist &&  provider.downloading == false ?  provider.openfile():
                    provider.cancelDownlad();
              },
                  child: Icon(Icons.close,size: 40,color: Colors.red,))
                
                ): SizedBox() ,
          ],
        ),
        Expanded(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            color: Color(0xff222222),
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Row(
         
              children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Text("Video Title....",textAlign: TextAlign.start,style: TextStyle(color: Colors.white),),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          videoList.data!.response!.title!.length > 10
                              ? "${videoList.data!.response!.title!.substring(0,10)}..."
                              : videoList.data!.response!.title!
                          
                          ,textAlign: TextAlign.start,style: TextStyle(color:Color(0xffFFFFFF),fontWeight: FontWeight.bold),),
                        SizedBox(width: 20,),
                        // Text("${formatBytes(int.parse(filterVideosList.contentLength ?? "00"),0)}mb",textAlign: TextAlign.start,style: TextStyle(color:Color(0xffFFFFFF),fontWeight: FontWeight.bold),),
                      ],
                    ),
                    ProgressIndicator(provider.progress,context),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(provider.speedShow.toString(),textAlign: TextAlign.start,style: TextStyle(color:Color(0xff00C950),fontWeight: FontWeight.bold),),
                        SizedBox(width: 90,),
                        Text("${(provider.progress * 100).toInt().toString()} %",textAlign: TextAlign.start,style: TextStyle(color:Color(0xffFFFFFF),fontWeight: FontWeight.bold),),
                      ],
                    ),
        
                   
        
                    
                  ],
                ),
                 Padding(
                   padding: const EdgeInsets.only(left:0),
                   child: IconButton(onPressed:press, icon:
        
                  provider.fileExist ? Icon(Icons.save,color: Colors.green,) :
                  Icon(Icons.download,color:provider.downloading ? Colors.pink:Colors.white,)
                   
                   ),
                 )
              ],
            ),
          ),
        )
      ],
    ),
   );
  }
}







Widget ProgressIndicator(progress,BuildContext context){
   return  Container(
            // margin: EdgeInsets.symmetric(vertical: 15),
            width: 180,
            height: 10,
            // color: Colors.yellow,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value:progress,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
                backgroundColor: Color(0xffD6D6D6),
              ),
            ),
          );
}