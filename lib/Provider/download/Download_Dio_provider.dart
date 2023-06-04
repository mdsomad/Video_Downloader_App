







import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/download_details_store_model/download_details_store_model.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';
import 'package:video_downloader_application/Provider/home/home_provider.dart';
import 'package:video_downloader_application/Services/notification_service.dart';
import 'package:video_downloader_application/Utils/Utils.dart';

class DownloadProvider with ChangeNotifier{



  bool _dowloading = false;
  bool get downloading => _dowloading;
  bool _fileExist = false;
  bool get fileExist => _fileExist;
  double progress = 0.0;
  int speedShow = 0;
  var prev = 0;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken;


  //TODO Create  setLoading function
setDownloading(bool value){
  _dowloading = value;
  notifyListeners();
}


  //TODO Create  setLoading function
setFileExist(bool value){
  _fileExist = value;
  notifyListeners();
}




 String formatBytes(int bytes, int decimals) {
    if (bytes == 00) return "(?) MB";
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +' ' + suffixes[i];
  }





downoadSpeed(recv_Byts){
   if(downloading == true){
       Timer(Duration(seconds: 1), () {{
          prev = 0;
          var next = recv_Byts;
          var speed =  next - prev;
          prev = speed;
          speedShow = speed;
          notifyListeners();
          print(formatBytes(prev,0));
       }});
   }
  

 
 
}

 

  Dio dio = Dio();
  

  Future<void> startDownloading({required String url,required String title,required String quality,required String type_Of_File}) async {
      

  
     
      
      //! final myString = 'abc=';
      //! final withoutEquals = myString.replaceAll(RegExp('='), ''); 
      //! print(withoutEquals);
      
     

      NotificationService notificationService = NotificationService();   //* <-- Create NotificationService Class object


     final status = await Permission.storage.request();

      if(status.isGranted){

       cancelToken = CancelToken();



    // ! final String date = DateTime.now().microsecondsSinceEpoch.toString();
    // ! fileName = "$date.mp4";
     
    

     fileName = "$title(${quality}).mp4";
    
      filePath = await _getFilePath1(fileName);

    setDownloading(true);
    
    progress = 0;

    
    //!  dio
    //  .download(
    //     url,
    //     filePathAndName,
    //     onReceiveProgress: (count, total) {
       
    //       progressStream.add(count / total);
    //     },
    //   ).asStream()
    //     .listen((event) {
       
    //   }).onDone(() {
    //     // Fluttertoast.showToast(msg: "Video downloaded");
       
    //   });


    

     dio.download(
      url.toString(),
      filePath,
      onReceiveProgress:(recivedBytes, totalBytes)async  {
            progress = recivedBytes / totalBytes;
            if(kDebugMode){
              print(progress);
            }

        //!  Future.delayed(const Duration(seconds: 1), () {
        // !     downoadSpeed(recivedBytes);
        //!      print('Yes Duration');
        //!   });
          
          notifyListeners();
         
      },cancelToken:cancelToken,
      deleteOnError: true,

      
    ).then((_) {
       setDownloading(false);
       setFileExist(true) ;
       notificationService.showNotification(title,filePath);
      // Navigator.pop(context);
    }).onError((error, stackTrace) {

       if(kDebugMode){

       
         print('Downloading failed error: ' + error.toString());
         print('Downloading failed stackTrace: ' + stackTrace.toString());
       }

      
      if(error.toString() == 'DioError [request cancelled]: The request was cancelled.'){
           Utils.toastMessage('Downloading cancelled', true,color: Colors.red);
       }else{
        
           Utils.toastMessage('Downloading failed try again', true,color: Colors.red);
       }

        
       
       setDownloading(false);
       setFileExist(false);
    });



     }else{
      if(kDebugMode){
        print("No Permission");
      }
    }
    
    
    
    
    
    

  }




  Future<String> _getFilePath1(String filename) async {
    // final dir = await getExternalStorageDirectory();
    final dir = Directory('/storage/emulated/0/Download');
    return "${dir.path}/$filename";
    // return "${dir!.path}/$filename";
  }
  



  cancelDownlad(){
     cancelToken.cancel();
     setFileExist(false);
     setDownloading(false);
  }




  checkFileExit()async{
    final storagedir = await _getFilePath1(fileName);
    bool fileExistCheck = await File(storagedir).exists();
    setFileExist(fileExistCheck);
     
  }

  


  openfile(){
    OpenFile.open(filePath);
  }





 List<DownloadDetailsStoreModel> _videoSaveList = [];
 List<DownloadDetailsStoreModel> get videoSaveList => _videoSaveList;



setVideoSaveList(DownloadDetailsStoreModel videoSaveModel){
    _videoSaveList.add(videoSaveModel);
    notifyListeners();
}

  
  
    
}











