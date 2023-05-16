import 'package:video_downloader_application/API_Url/api_url.dart';
import 'package:video_downloader_application/Data/network/BaseApiServices.dart';
import 'package:video_downloader_application/Data/network/NetworkAPIServices.dart';
import 'package:video_downloader_application/Models/Video_Model.dart';

class HomeController{


BaseAPIServices _apiServices = NetworkApiServices();  //TODO Create object NetworkApiServices class call

 // TODO Video Get Function Create
 Future<VideoModel> fetchVideoLinkList(String PassVideoUrl)async{
  try {                      //*obj call                //* AppUrl class call loginEndPint url
    // dynamic response = await _apiServices.getGetApiRespons("http://10.0.2.2:3000/youtube-video/?url=${PassVideoUrl}");             //* <-- getGetApiRespons Function call
    // return VideoModel.fromJson(response);
    dynamic response = await _apiServices.getGetApiRespons("https://youtube-download.cyclic.app/youtube-video/?url=${PassVideoUrl}");             //* <-- getGetApiRespons Function call
    return  VideoModel.fromJson(response);
  } catch (e) {
     throw e;
  }
 }







}