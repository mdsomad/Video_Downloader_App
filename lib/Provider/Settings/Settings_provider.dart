
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_downloader_application/Services/user_preference.dart';





class SettingsProvider with ChangeNotifier{

   bool _downloading = false;
   bool get downloading => _downloading;



  setDownloading(bool value) {
       _downloading = value;
       UserPreference.saveDownloading(value);
       notifyListeners();
   }



  getSeveDownloading() async{

       //* UserPreference Class ka getDownloading Function Call Raha hai
       await UserPreference.getDownloading().then((value){

            if(kDebugMode){
               print('UserPreference SaveValue This --> $value');
             }
        
          if(value == null){
            _downloading = value?? false;
          }else{
             _downloading = value;
          }
         notifyListeners();
      });
  }



  
}