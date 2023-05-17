
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_downloader_application/Repository/home_repository.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';
import 'package:video_downloader_application/Utils/Utils.dart';




class HomeProviderModel with ChangeNotifier{

  final _myRepo = HomeRepository();

String _controllerValueChack = "";
String get controllerValueChack => _controllerValueChack;


//TODO Create  setLoading function
setcontrollerValueChack(String value){
  _controllerValueChack = value;
  notifyListeners();
}




  bool _isDataLoaded = false;
  bool get isDataLoaded => _isDataLoaded;



    //TODO Create  setLoading function
  setDataLoaded(bool value){
    _isDataLoaded = value;
    notifyListeners();
  }









//  List<VideoModel> _videoList = [];
//  List<VideoModel> get videoList => _videoList;
//    setVideo (VideoModel value){       //* <-- Yah hai loading ka function
//      if(_videoList.isNotEmpty){
//         _videoList.clear();
//      }
//      _videoList.add(value);
    
//      print(value.title);
//      notifyListeners();
//   }

ApiResponse<VideoModel> videoList = ApiResponse.isEmpty("Enter A Youtube Video Link");

  setMoviesList(ApiResponse<VideoModel>response){
    videoList = response;
    notifyListeners();
  }

  
  
  Future<void> fatchVideoListApi (var PassVideoUrl)async{

      setMoviesList(ApiResponse.loading());
       setDataLoaded(false);
       print('data loading');
       
       _myRepo.fetchVideoLinkList(PassVideoUrl).then((value){
        // setVideo(value);
        print(value.status.toString());
        if(value.status.toString() == "FAILED"){
           setMoviesList(ApiResponse.error("Request Failed, Please Try Again"));
           setDataLoaded(false);
        }else{
           setMoviesList(ApiResponse.completed(value));
           setDataLoaded(true);
        }

         notifyListeners();
        if(kDebugMode){
          print('Data this --> $value');
        }

    }).onError((error, stackTrace){

       setMoviesList(ApiResponse.error(error.toString()));
       setDataLoaded(false);
        if(kDebugMode){
          print("Error This --> ${error.toString()}");
        }

    });


    if(kDebugMode){
      print('End Run');
    }
    
  }










 String fileName = "";
 bool _downloading = false;
 bool get downloading => _downloading;
 setDownloading(bool value){
   _downloading = value;
  notifyListeners();
 }

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
    //  Utils.toastMessage("Downloading Started...",true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Downloading Started...",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),backgroundColor: Colors.yellow[500],));
     final id = await FlutterDownloader.enqueue(
        url: url,
        savedDir: basrStorage!.path,
        fileName: fileName,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        saveInPublicStorage: true
       ).whenComplete(() =>{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Downloaded Sucessfully",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: Colors.green[700],))
        // Utils.toastMessage("Downloaded Sucessfully",true),
          ,setDownloading(false)
       });

        
      } catch (e) {
         setDownloading(false);
          Utils.ftushBarErrorMessage("Downloading feld",context);
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








  

  
  
  
}