import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';
import 'package:video_downloader_application/Provider/download/Download_Dio_provider.dart';




class VideoDownloadDisplayWidget extends StatelessWidget {
  final String thumbnails;
  final String title;
  final VoidCallback press;
  VideoDownloadDisplayWidget({super.key, required this.thumbnails, required this.title, required this.press});


   String formatBytes(int bytes, int decimals) {
    if (bytes == 00) return "(?) MB";
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +' ' + suffixes[i];
  }
  
  
  @override
  Widget build(BuildContext context) {
    return  Consumer<DownloadProvider>(  //* <-- Provider Use
        builder: (context, provider, child) {
    
    return Container( 
    height: MediaQuery.of(context).size.height *.13,
    width: MediaQuery.of(context).size.width,
    color: Colors.grey,
    child: Row(
      //  shrinkWrap: true,
      // scrollDirection: Axis.horizontal,
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
                width: MediaQuery.of(context).size.width *.31,
                // color: Color(0xff4F4F4F),
                child: Image.network(
                  thumbnails,
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
                         title.length > 20
                              ? "${title.substring(0,20)}..."
                              : title
                          
                          ,textAlign: TextAlign.start,style: TextStyle(color:Color(0xffFFFFFF),fontWeight: FontWeight.bold),),
                        //  SizedBox(width: 20,),
                        // Text("${formatBytes(int.parse(filterVideosList.contentLength ?? "00"),0)}mb",textAlign: TextAlign.start,style: TextStyle(color:Color(0xffFFFFFF),fontWeight: FontWeight.bold),),
                      ],
                    ),
                    ProgressIndicator(provider.progress,context),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(""
                          //formatBytes(provider.prev,0)
                         ,textAlign: TextAlign.start,style: TextStyle(color:Color(0xff00C950),fontWeight: FontWeight.bold),),
                         SizedBox(width: MediaQuery.of(context).size.width *.4,),
                        Text("${(provider.progress * 100).toInt().toString()} %",textAlign: TextAlign.start,style: TextStyle(color:Color(0xffFFFFFF),fontWeight: FontWeight.bold),),
                      ],
                    ),
        
            
                  ],
                ),
                 IconButton(onPressed:press, icon:
                  provider.fileExist && provider.downloading == false ? Icon(Icons.save,color: Colors.green,) :
                  Icon(Icons.download,color:provider.downloading ? Colors.pink:Colors.white,)
                 )
              ],
            ),
          ),
        )
      ],
    ),
     );

        });
  }
}







Widget ProgressIndicator(progress,BuildContext context){
   return  Container(
            // margin: EdgeInsets.symmetric(vertical: 15),
            width: MediaQuery.of(context).size.width *.5,
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