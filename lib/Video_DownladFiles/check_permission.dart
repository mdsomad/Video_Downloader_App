import 'package:permission_handler/permission_handler.dart';

class CheckPermission{






isStoragePermission2() async {
    var isStorage = await Permission.storage.status;
    if (!isStorage.isGranted) {
      await Permission.storage.request();
      if (!isStorage.isGranted) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }


  

 Future<bool> idStoragePermission()async{
    var isStorage = await Permission.storage.status;
    var isAcceslc = await Permission.accessMediaLocation.status;
    var isMangExt = await Permission.manageExternalStorage.status;

    if(!isStorage.isGranted || !isAcceslc.isGranted || !isMangExt.isGranted){
         await Permission.storage.request();
         await Permission.accessMediaLocation.request();
         await Permission.manageExternalStorage.request();

         if(!isStorage.isGranted || !isAcceslc.isGranted || !isMangExt.isGranted){
            return false;
          }else{
            return true;
          }
        }else{
          return true;
        }
    
  }
}