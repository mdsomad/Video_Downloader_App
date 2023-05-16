import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_downloader_application/Utils/Utils.dart';
import 'package:video_downloader_application/Video_DownladFiles/directory_path.dart';

class FlutterDownloaderProvider with ChangeNotifier{



   
 var getPathFile = DirectoryPath();
 bool _downloading = false;
 bool get downloading => _downloading;
 setDownloading(bool value){
   _downloading = value;
    notifyListeners();
 }
 String fileName = "";

  downloadFile(String url,String videoTitle,String videoquality,bool isAudio, BuildContext context)async{
    final status = await  Permission.storage.request();

    if(status.isGranted){

      try {
      final basrStorage = await getExternalStorageDirectory();
      if(isAudio == true){
          fileName = "$videoTitle($videoquality).mp3";
      }else{
          fileName = "$videoTitle($videoquality).mp4";
      }  
      
     setDownloading(true);
     Utils.toastMessage("Downloading Start",true);
     final id = await FlutterDownloader.enqueue(
        url: url,
        savedDir: basrStorage!.path,
        fileName: fileName,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        saveInPublicStorage: true
       ).whenComplete(() =>{
        Utils.toastMessage("Downloading Complete",true),
          setDownloading(false)
       });

        
      } catch (e) {
         setDownloading(false);
          Utils.ftushBarErrorMessage("Download feld",context);
          Utils.ftushBarErrorMessage(e.toString(), context);
         if(kDebugMode){
            print(e);
         }
      }
      
    
      
      
    }else{
      if(kDebugMode){
        print("No Permission");
      }
    }

    
  }

  

int progress = 0;
ReceivePort receivePort = ReceivePort();



flutterDownloaderInitialize(){


    IsolateNameServer.registerPortWithName(receivePort.sendPort,'downloadingvideo');
   
    receivePort.listen((message) {
           progress = message;
           Utils.toastMessage(progress.toString(),false);
           print("progress Value this --> $progress");
           notifyListeners();
    
     });
    
    FlutterDownloader.registerCallback(downloadCallback);

  }


   

  static downloadCallback(id, status, progress){
    final SendPort? receivePort = IsolateNameServer.lookupPortByName('downloadingvideo');
    receivePort!.send(progress);
}



disposeFlutter(){
  IsolateNameServer.removePortNameMapping('downloadingvideo');
}







  



  
}