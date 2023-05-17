// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';

import 'package:video_downloader_application/Provider/FlutterDownloader_provider.dart';
import 'package:video_downloader_application/Video_DownladFiles/directory_path.dart';

class DoenloadloadFile extends StatefulWidget {
  var filterVideosList;
  List<VideoModel> videoList;
  DoenloadloadFile({
    Key? key,
    required this.filterVideosList,
    required this.videoList,
  }) : super(key: key);

  @override
  State<DoenloadloadFile> createState() => _DoenloadloadFileState();
}

class _DoenloadloadFileState extends State<DoenloadloadFile> {
   var getPathFile = DirectoryPath();
  String fileName = "";

  _downloadFile()async{
    final status = await  Permission.storage.request();

    if(status.isGranted){
      final basrStorage = await getExternalStorageDirectory();
      var stortPath = await getPathFile.getPath();
       final String date = DateTime.now().microsecondsSinceEpoch.toString();
      
        // final title = widget.videoList[0].title;
        // fileName = "$title(${widget.filterVideosList.quality}).mp4";


     final taskId = await FlutterDownloader.enqueue(
          url: widget.filterVideosList.url.toString(),
          headers: {}, // optional: header send with url (auth token etc)
          savedDir: stortPath,
          fileName: fileName,
          showNotification: true, // show download progress in status bar (for Android)
          openFileFromNotification: true, // click on notification to open downloaded file (for Android)
          saveInPublicStorage:true
        );


    //  final id = await FlutterDownloader.enqueue(
    //     url: widget.filterVideosList.url.toString(),
    //     // url: "https://rr4---sn-o097znsr.googlevideo.com/videoplayback?expire=1682945892&ei=BGNPZIPJJ6eDsfIPgJuxyA8&ip=13.52.98.54&id=o-AJgWE9Rj7t22SvUY02_ISlhtSGWDKCPC13_Of8Nn-Tw0&itag=18&source=youtube&requiressl=yes&mh=Uc&mm=31%2C26&mn=sn-o097znsr%2Csn-a5msenl7&ms=au%2Conr&mv=m&mvi=4&pl=19&pcm2=yes&initcwndbps=1521250&vprv=1&mime=video%2Fmp4&ns=Ot4e-K0dtP5jC6S8bKd_UowN&gir=yes&clen=4321199&ratebypass=yes&dur=57.749&lmt=1679953413678797&mt=1682923984&fvip=5&fexp=24007246&c=WEB&txp=5430434&n=xX5wU-tWzn9mUw&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cpcm2%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIgc7Z8vb8O6QAjizQMPtWGk16BtaOjZflXZ6KCzlR_en8CIQDmvejo0KRocd24iN_-hMc_op29NJF74HnIfkQITEDuQw%3D%3D&sig=AOq0QJ8wRgIhAK7TcLMB6IN4izvuG3mzwM83kP3iZ95rxuYoiUxAV70MAiEAqXC857krp0u75og0sVSvmh84mQAeXtW8sNZl-y7qNAA%3D",
    //     savedDir: stortPath,
    //     fileName: fileName,
    //     showNotification: true, // show download progress in status bar (for Android)
    //     openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    //     saveInPublicStorage: true
    //    );
      
      
    }else{
      print("No Permission");
    }

    
  }






int progress = 0;
ReceivePort _port = ReceivePort();

@override
void initState() {
_downloadFile();
  IsolateNameServer.registerPortWithName(_port.sendPort,'downloader_send_port');
  _port.listen((dynamic data) {
    String id = data[0];
    DownloadTaskStatus status = data[1];
    setState((){
         progress = data[2];
         print("--------------> ${data[2]}");
     });
  });

  FlutterDownloader.registerCallback(downloadCallback);
  super.initState();
}


@pragma('vm:entry-point')
static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
  send!.send([id, status, progress]);
}

@override
void dispose() {
  IsolateNameServer.removePortNameMapping('downloader_send_port');
  super.dispose();
}
















// int progress = 0;
// ReceivePort receivePort = ReceivePort();

// @override
//   void initState() {
//     // TODO: implement initState

//     // Provider.of<FlutterDownloaderProvider>(context,listen:false).flutterDownloaderInitialize();

//   // if(widget.url != null || widget.url != ""){
//   //   Provider.of<FlutterDownloaderProvider>(context,listen:false).downloadFile(widget.url);
//   // }





//     IsolateNameServer.registerPortWithName(receivePort.sendPort,'downloadingvideo');

//     receivePort.listen((message) {

//     String id = message[0];
//     DownloadTaskStatus status = message[1];
//       setState((){ 
//          progress = message[2];
//       });
//        print(" CAll progress value this --> $progress");
//       // });
//       // setState(() {
//       //     
//      });
    
    
//     FlutterDownloader.registerCallback(downloadCallback);
    
    
//     super.initState();
//   }


//  static downloadCallback(id, status, progress){
//     final SendPort? sendPort  = IsolateNameServer.lookupPortByName('downloadingvideo');
//     sendPort!.send(progress);
// }











  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Consumer<FlutterDownloaderProvider>(  //* <-- Provider Use
        builder: (context, provider, child) {
        return Scaffold(
       
       body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

         children: [
           Text("progress",style: TextStyle(fontSize: 25)),
           Text("$progress",style: TextStyle(fontSize: 50),),
         ],
       ),),


       floatingActionButton: FloatingActionButton(onPressed:_downloadFile
       
      //  (){
      //      provider.downloadFile(widget.url);
      //  }
       
       
       ,child: Icon(Icons.download),
       ),
      
       
    );


  });
    
    
    
    
    

  }
}