







import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';

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


downoadSpeed(recv_Byts){
  prev = 0;
  var next = recv_Byts;
  var speed =  next - prev;
  prev = speed;
  speedShow = speed;
  notifyListeners();
 
}
  

  Dio dio = Dio();
  

  Future<void> startDownloading(var filterVideosList, ApiResponse<VideoModel> videoList,BuildContext context) async {
     
     //! This Code currently not Use
     final status = await Permission.storage.request();

      if(status.isGranted){

       cancelToken = CancelToken();



    //  final String date = DateTime.now().microsecondsSinceEpoch.toString();
    //  fileName = "$date.mp4";
     

     final title = videoList.data!.response!.title;

     fileName = "$title(${filterVideosList.quality}).mp4";
    
      filePath = await _getFilePath1(fileName);

    setDownloading(true);
    
    progress = 0;

    await dio.download(
      filterVideosList.url.toString(),
      filePath,
      onReceiveProgress:(recivedBytes, totalBytes) {
          progress = recivedBytes / totalBytes;
          notifyListeners();
          print(progress);
      },cancelToken:cancelToken,
      deleteOnError: true,

      
    ).then((_) {
       setDownloading(false);
       setFileExist(true) ;
      // Navigator.pop(context);
    }).onError((error, stackTrace) {
       setDownloading(false);
    });



     }else{
      if(kDebugMode){
        print("No Permission");
      }
    }
    
    
    
    
    
    

  }



  //! Not Use
  Future<String> _getFilePath1(String filename) async {
    // final dir = await getApplicationDocumentsDirectory();
    final dir = Directory('/storage/emulated/0/Download');
    return "${dir.path}/$filename";
  }
  



     cancelDownlad(){
       cancelToken.cancel();
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
  
    
}