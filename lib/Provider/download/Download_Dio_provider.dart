import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';
import 'package:video_downloader_application/Video_DownladFiles/check_permission.dart';
import 'package:video_downloader_application/Video_DownladFiles/directory_path.dart';







class DownloadProvider with ChangeNotifier{



 bool _isPermission = false;
 bool get isPermission => _isPermission;


 var checkALlPermissions = CheckPermission();

 checkPermission()async{
    var permission = await checkALlPermissions.idStoragePermission();
    if(permission){
      print("checkPermission retune value This --> $permission");
      setIsPermission(true);
    }
    
 }


 setIsPermission(bool value){
     _isPermission = value;
     notifyListeners();
 }
 

  
  
  
  
  
  
  
  
  



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
  var getPathFile = DirectoryPath();


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
  

  void startDownloading(var filterVideosList, ApiResponse<VideoModel> videoList,BuildContext context) async {
     
     
     //! This Code currently not Use
    //  final status = await  Permission.storage.request();
    //   if(status.isGranted){

    //  }else{
    //   if(kDebugMode){
    //     print("No Permission");
    //   }
    // }
    
    
    
    
    
    cancelToken = CancelToken();
    // const String url ='https://firebasestorage.googleapis.com/v0/b/e-commerce-72247.appspot.com/o/195-1950216_led-tv-png-hd-transparent-png.png?alt=media&token=0f8a6dac-1129-4b76-8482-47a6dcc0cd3e';
    // final String date = DateTime.now().microsecondsSinceEpoch.toString();
     final title = videoList.data!.response!.title;
     fileName = "$title(${filterVideosList.quality}).mp4";

    var stortPath = await getPathFile.getPath();
    filePath = "$stortPath/$fileName";
    // String filePath = await _getFilePath(fileName);

    setDownloading(true);
    progress = 0;

    await dio.download(
      filterVideosList.url.toString(),
      filePath,
      onReceiveProgress:(recivedBytes, totalBytes) {
          // downoadSpeed(recivedBytes);
          // speedShow = recivedBytes;
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

  }



  //! Not Use
  // Future<String> _getFilePath(String filename) async {
  //   // final dir = await getApplicationDocumentsDirectory();
  //   final dir = Directory('/storage/emulated/0/Download');

  //   return "${dir.path}/$filename";
  // }
  



     cancelDownlad(){
       cancelToken.cancel();
       setDownloading(false);
    }




  checkFileExit()async{
     var stortPath = await getPathFile.getPath();
     filePath = "$stortPath/$fileName";
     bool fileExistCheck = await File(filePath.toString()).exists();
     setFileExist(fileExistCheck);
     
  }

  


  openfile(){
    OpenFile.open(filePath);
  }
  
    
}