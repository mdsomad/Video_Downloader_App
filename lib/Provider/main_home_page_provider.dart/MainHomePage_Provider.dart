import 'package:flutter/foundation.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/youtube_video/Video_Model.dart';

class MainHomePageProvider with ChangeNotifier{

  
int _currentIndex = 0;
int get currentIndex => _currentIndex;


 late final dynamic videoList;
 late final dynamic filterVideosList;

setVideoList(dynamic value){
   videoList = value;
   notifyListeners();
}
setFilterVideosList(dynamic value){
   filterVideosList = value;
   notifyListeners();
}
setCurrentIndex(int value){
   _currentIndex = value;
   notifyListeners();
}

  
  
}