
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/Video_Model.dart';
import 'package:video_downloader_application/Provider/FlutterDownloader_provider.dart';
import 'package:video_downloader_application/Provider/home_provider.dart';
import 'package:video_downloader_application/Screens/download/Download_Page.dart';
import 'package:video_downloader_application/Screens/download/Download_Dio_Page.dart';
import 'package:video_downloader_application/Video_DownladFiles/downloadload_file.dart';
import 'package:video_downloader_application/Video_DownladFiles/file_list.dart';
import 'package:video_downloader_application/Video_DownladFiles/testdownload.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';
import '../Video_DownladFiles/Download_Page.dart';






// 1 : https://www.youtube.com/watch?v=No10r3PLLCU&list=RDNo10r3PLLCU&start_radio=1&ab_channel=JESHRECORDS

// 2 : https://www.youtube.com/watch?v=rxMmistOjCA&list=RDrxMmistOjCA&start_radio=1&ab_channel=T-Series





Container Haider(TextEditingController controller,VoidCallback onPreass, VoidCallback onClearPreass,String controllerValueChack,BuildContext context){

  return Container(
    height: 140,
    color: AppColor.appBarColor2,
    
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          
          
          controller: controller,
          // textInputAction:TextInputAction.next,
          textInputAction: TextInputAction.search,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            
            hintText: "Enter video link",
              
            suffixIcon:

            Container(
              // color: Colors.pink,
               padding: EdgeInsets.symmetric(horizontal: 0,vertical: 7),
               margin: EdgeInsets.only(right: 0),
              child: Row(
                 mainAxisSize: MainAxisSize.min,
                children: <Widget>[
               Provider.of<HomeProviderModel>(context,listen: false).controllerValueChack.isNotEmpty  ? 
              IconButton(
              icon: Icon(Icons.clear,color: Colors.white,),
              onPressed: onClearPreass,
              ):SizedBox(),
                  TextButton(
                    child: Icon(
                    Icons.search,color: Colors.white,size: 30),
                    style: ButtonStyle(overlayColor:
                    MaterialStateColor.resolveWith((states) =>Colors.white.withOpacity(0.1)),
                    shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(50.0),
                    ))),
                    onPressed:onPreass,
                  ),
                ],
              ),
            ),



            // Provider.of<HomeProviderModel>(context,listen: false).controllerValueChack.isNotEmpty  ? IconButton(onPressed: onClearPreass, icon:Icon(Icons.close,color: Colors.white,size: 30)) : IconButton(onPressed: onPreass, icon:Icon(Icons.search,color: Colors.white,size: 30)),
            //  Provider.of<HomeProviderModel>(context,listen: false).controllerValueChack.isNotEmpty  ? IconButton(onPressed: onClearPreass, icon:Icon(Icons.close,color: Colors.white,size: 30)) : IconButton(onPressed: onPreass, icon:Icon(Icons.search,color: Colors.white,size: 30)),
            // suffixIcon: Icon(Icons.search,color: Colors.white,size: 30,),

            enabledBorder: OutlineInputBorder(
               borderSide: BorderSide(width: 2, color: AppColor.white), //<-- SEE HERE
            ),

            focusedBorder: OutlineInputBorder(
               borderSide: BorderSide(width: 2, color: Colors.amberAccent),
            ),
            
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
               borderSide: const BorderSide(color: Colors.white,),
            ),
            hintStyle: TextStyle(
              color: Colors.white
            ),
          
            
          ),

          onChanged: (value) {
            Provider.of<HomeProviderModel>(context,listen: false).setcontrollerValueChack(value);
            print(value);
          },
          
        ),
      ),
    ),
  );
}








Widget CardBody(ApiResponse<VideoModel> videoList,provider,BuildContext context){

   //* Video List Filter
  List? filterVideosList = videoList.data!.response!.videos?.where(((element) => element.hasAudio == true )).toList();

     //* List Reversed
     filterVideosList = new List.from(filterVideosList!.reversed);

   //* Audios List Filter
   //  audios = audios.where(((element) => element.audioFormat == "mp4" )).toList();




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


 

  
  return
  
   


          
   Container(
  // height: 500,
   width: MediaQuery.of(context).size.width / 1.1,
  decoration: BoxDecoration(
     color: AppColor.cardColor,
     borderRadius: BorderRadius.circular(10),
     border: Border.all(color:AppColor.white,width: 1.5)
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      videoThumbnailCard(videoList,context),
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
          itemCount:filterVideosList.length,
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
              Text(filterVideosList![index].quality.toString(),style:TextStyle(color:AppColor.white)),
              Text(filterVideosList[index].fps.toString(),style:TextStyle(color:AppColor.white)),
              //* Text("1920 x 1080 (mp4,60fps)",style:TextStyle(color:AppColors.white)),
              Spacer(),
              Text(
                //!getFileSizeString(bytes:int.parse(videos[index].contentLength))
                formatBytes(int.parse(filterVideosList[index].contentLength ?? "00"),0),
                //* "300mb",
              
              style:TextStyle(color:AppColor.white)),

               TextButton(onPressed: (){
              //  provider.downloadFile(filterVideosList![index].url.toString(),videoList.data!.response!.title.toString(),filterVideosList[index].quality.toString(),false,context);
              Navigator.push(context, MaterialPageRoute(builder: ((context) => DownloadPage2(filterVideosList:filterVideosList![index],videoList:videoList,))));

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




       Container(
        width: double.infinity,
        height: 21,
        color: AppColor.green,
        child: Row(
          children: [
           const SizedBox(width: 20,),
            Text("AUDIO",style: TextStyle(color:AppColor.white,fontWeight: FontWeight.bold),),
          ],
        ),
      ),

      Container(
        // height: 150,
        
        child: ListView.builder(
          itemCount:videoList.data!.response!.audios!.length,
          //  shrinkWrap: true,
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
             
              Text(videoList.data!.response!.audios![index].audioFormat.toString(),style:const TextStyle(color:AppColor.white)),
             
              Spacer(),

              Text(
                

                //! getFileSizeString(bytes:int.parse(videos[index].contentLength))
                formatBytes(int.parse(videoList.data!.response!.audios![index].contentLength ?? "00"),0),
              
              style:TextStyle(color:AppColor.white)),

              TextButton(onPressed: (){
                provider.downloadFile(videoList.data!.response!.audios![index].url.toString(),videoList.data!.response!.title.toString(),videoList.data!.response!.audios![index].quality.toString(),true,context);

              }, 
              style: ButtonStyle(overlayColor:
                    MaterialStateColor.resolveWith((states) =>Colors.white.withOpacity(0.1)),
                    shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(100.0),
                    ))),
                child:Icon(Icons.download,color:AppColor.downloadIcon,size:18 ,))
          ],),
        );
        },),
      ),

     
      
    ],
  )
  );


 
}







//TODO videoThumbnailCard Fubction
Container videoThumbnailCard(ApiResponse<VideoModel> videoList,BuildContext context){


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



