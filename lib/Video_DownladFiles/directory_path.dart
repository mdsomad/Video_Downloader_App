
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DirectoryPath{

  getPath() async{
    // final path = Directory("/storage/emulated/@/Android/media/com.example.download_any_file/files");
    final path = Directory('/storage/emulated/0/BetaYouTubedownloader');
    // final path = Directory('/storage/emulated/0/Download');
    // final basrStorage = await getExternalStorageDirectory();
    if(await path.exists()){
       return path.path;
    }else{
      path.create();
      return path.path;
    }
  }



  // Future<String> getFilePath(String filename) async {
  //   final basrStorage = await getExternalStorageDirectory();
  //   return "${basrStorage}/$filename";
  // }





getFilePath() async {
    final Directory? tempDir = await getExternalStorageDirectory();
    final filePath = Directory(tempDir!.path);
    if (await filePath.exists()) {
      return filePath.path;
    } else {
      await filePath.create(recursive: true);
      return filePath.path;
    }
  }

  
  
}