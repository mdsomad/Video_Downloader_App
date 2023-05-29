
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:video_downloader_application/Data/response/status.dart';
import 'package:video_downloader_application/Models/Instagram_reel/instagram_reel_model.dart';
import 'package:video_downloader_application/Repository/home_repository.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';
import 'package:video_downloader_application/Utils/Utils.dart';




class HomePageProvider with ChangeNotifier{

  final _myRepo = HomeRepository();

  TextEditingController videoLinkController = TextEditingController();
  









late StreamSubscription _intentData;

//TODO Create ReceiveSharingIntentFunction Function
ReceiveSharingIntentFunction(){

        _intentData = ReceiveSharingIntent.getTextStream().listen((String value) {
              if(value != '' && value != null){
                setcontrollerValueChack(value);
                videoLinkController.text = value;
                checkVideoPlatformThenApiCall(value.trim());
                notifyListeners();

                if(kDebugMode){
                  print("Yes ReceiveSharing Data 1 --> $value");
                } 
                
                
            }else{
              if(kDebugMode){
                  print("This ReceiveSharing Data 1 --> $value");
               }
           
             }
          
          
         
    });





   ReceiveSharingIntent.getInitialText().then((String? value){
          if(value != '' && value != null){
              setcontrollerValueChack(value);
              videoLinkController.text = value;
              checkVideoPlatformThenApiCall(value.trim());
              notifyListeners();


            if(kDebugMode){
               print("Yes ReceiveSharing Data 2 --> $value");
            } 
                
              
              
          }else{
              if(kDebugMode){
                  print("This ReceiveSharing Data 2 --> $value");
              } 
         }
         
          

      }).onError((error, stackTrace){
         if(kDebugMode){
           print("getLinkStream error: $error");
         }
      });
  }
  
  
  
  
  
  




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







  String _checkVideoPlatformLink = "";
  String get checkVideoPlatformLink => _checkVideoPlatformLink;



  //TODO Create  setLoading function
  setCheckVideoPlatformLink(String value){
    _checkVideoPlatformLink = value;
    notifyListeners();
  }







ApiResponse<VideoModel> videoList = ApiResponse.isEmpty("Enter A Video Link");

  setMoviesList(ApiResponse<VideoModel>response){
    videoList = response;
    notifyListeners();
  }



ApiResponse<InstagramReelModel> instagramVideo = ApiResponse.isEmpty("Enter A Video Link");

  setinstagramVideo(ApiResponse<InstagramReelModel>response){
    instagramVideo = response;
    notifyListeners();
  }






 //TODO Create checkvideoplatform function  (Them Api call)
 void checkVideoPlatformThenApiCall(String PassVideoUrl){
   if(PassVideoUrl.contains("https://www.instagram.com")){
        if(kDebugMode){
          print("This is a instagram Url");
        }
       setCheckVideoPlatformLink("instagram");
       instagramApi(PassVideoUrl);
   }else if(PassVideoUrl.contains("https://www.facebook.com")){
       if(kDebugMode){
          print("This is a facebook Url");
        }
       setCheckVideoPlatformLink("facebook");    
   }else{
         if(kDebugMode){
          print("This is a Youtube Url");
        }
       setCheckVideoPlatformLink("youtube");
       youtubeApi(PassVideoUrl);
   }
 }

  
  
  





  //TODO Create youtubeApi function
  Future<void> youtubeApi (var PassVideoUrl)async{

  

      setMoviesList(ApiResponse.loading());
       setDataLoaded(false);
       print('data loading');
       
       _myRepo.fetchVideoLinkList(PassVideoUrl).then((value){


        if(value.status.toString() == "FAILED"){
           setMoviesList(ApiResponse.error("Request Failed, Please Try Again"));
           setDataLoaded(false);
        }else{
           setMoviesList(ApiResponse.completed(value));
           setDataLoaded(true);
        }

         notifyListeners();
        if(kDebugMode){
          print('Youtube Data this Channe Name --> ${value.response!.channelName}');
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








  //TODO Create instagramApi function
  Future<void> instagramApi (var PassVideoUrl)async{

      setinstagramVideo(ApiResponse.loading());

      setDataLoaded(false);

        print('data loading');
       
       _myRepo.instagramApi(PassVideoUrl).then((value){
        
        print(value.status.toString());
        if(value.status.toString() == "FAILED"){
           setinstagramVideo(ApiResponse.error("Request Failed, Please Try Again"));
           setDataLoaded(false);
        }else{
           setinstagramVideo(ApiResponse.completed(value));
           setDataLoaded(true);
        }

         notifyListeners();

        if(kDebugMode){
          print('Instagram Data this User name --> ${value.response.author.name}');
          print('Data this --> $value');
        }

    }).onError((error, stackTrace){

       setinstagramVideo(ApiResponse.error(error.toString()));
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