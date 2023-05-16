// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import "package:path/path.dart" as Path;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:video_downloader_application/Video_DownladFiles/check_permission.dart';
import 'package:video_downloader_application/Video_DownladFiles/directory_path.dart';

class FileList extends StatefulWidget {
 final String url;
  FileList({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<FileList> createState() => _FileListState();
}

class _FileListState extends State<FileList> {

 bool isPermission = false;
 var checkALlPermissions = CheckPermission();

 checkPermission()async{
    var permission = await checkALlPermissions.idStoragePermission();
    if(permission){
      setState(() {
        isPermission = true;
      });
    }
    
 }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
  }
 
 
  
  var dataList = [
    {
      "id": "2",
      "title": "file Video 1",
      "url": ""
    },
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isPermission ? ListView.builder(
        itemCount: dataList.length,
        itemBuilder:(context, index) {
          var data = dataList[index];
           return TileList(fileUrl:widget.url.toString(), title: data['title'].toString(),);
      },):Center(child: TextButton(onPressed: (){
        checkPermission();
      }, child: Text("Permission issue"))),
    );
  }
}



class TileList extends StatefulWidget {
  final String fileUrl;
  final String title;
   TileList({
    Key? key,
    required this.fileUrl,
    required this.title,
  }) : super(key: key);

  @override
  State<TileList> createState() => _TileListState();
}

class _TileListState extends State<TileList> {
  bool dowloading = false;
  bool fileExist = false;
  double progress = 0.0;
  String fileName = "video2.mp4";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();

   Dio dio = Dio();

  startDownload() async{
    cancelToken = CancelToken();
    var stortPath = await getPathFile.getPath();
    //  filePath = "$stortPath/video2.mp4";
    //  var stortPath = await getPathFile.getFilePath('videosd.mp4');
     filePath = "$stortPath/$fileName";


     setState(() {
       dowloading = true;
       progress = 0;
     });

    try {

      
   
      await dio.download(
      widget.fileUrl,
      filePath,
      onReceiveProgress: (recivedBytes, totalBytes) {
        setState(() {
          progress = recivedBytes / totalBytes;
        });

        print(progress);
      },cancelToken: cancelToken,
      deleteOnError: true
        
        // widget.fileUrl,
        // filePath,
        //  onReceiveProgress: (count, total){
        //   setState(() {
        //     progress = (count / total);
        //   });
        //  },cancelToken: cancelToken
         
         );

        setState(() {
          dowloading = false;
          fileExist = true;
        });
        
    } catch (e) {
        setState(() {
          dowloading = false;
        
        });
    }
    
  }


cancelDownlad(){
   cancelToken.cancel();
   setState(() {
      dowloading = false;
   });
}

  
  
  checkFileExit()async{
     var stortPath = await getPathFile.getPath();
     filePath = "$stortPath/$fileName";
     bool fileExistCheck = await File(filePath).exists();
     setState(() {
       fileExist = fileExistCheck;
     });
  }



openfile(){
  OpenFile.open(filePath);
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fileName = Path.basename(widget.fileUrl);
       
    });
    checkFileExit();
  }
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.shade100,
      child: ListTile(
        title: Text(widget.title),
        leading: IconButton(onPressed: (){
          fileExist && dowloading == false ? openfile():
          cancelDownlad();
        },icon:fileExist && dowloading == false ? Icon(Icons.window,color: Colors.green,) : Icon(Icons.close),),
        trailing: IconButton(onPressed: (){
          fileExist && dowloading == false 
          ? openfile()
          :startDownload();
        },
        icon:
         fileExist ? Icon(Icons.save,color: Colors.green,) :
         dowloading ? Stack(
          alignment: Alignment.center,
          children: [
                 CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 3,
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  
                  ),
                  Text("${(progress*100).toStringAsFixed(2)}",style: TextStyle(fontSize: 12),)
          ],
         ):

         Icon(Icons.download) ,
        
        
        )
      ),
    );
  }
}
