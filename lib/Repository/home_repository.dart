import 'package:video_downloader_application/API_Url/api_url.dart';
import 'package:video_downloader_application/Data/network/BaseApiServices.dart';
import 'package:video_downloader_application/Data/network/NetworkAPIServices.dart';
import 'package:video_downloader_application/Models/Video_Model.dart';
import 'package:video_downloader_application/res/App_url/app_url.dart';





class HomeRepository{


BaseAPIServices _apiServices = NetworkApiServices();  //TODO Create object NetworkApiServices class call

 // TODO Video Get Function Create
 Future<VideoModel> fetchVideoLinkList(String PassVideoUrl)async{
  try {                      //*obj call                //* AppUrl class call loginEndPint url
    // dynamic response = await _apiServices.getGetApiRespons(AppUrl.localhostYoutubeVideoApi+PassVideoUrl);             //* <-- getGetApiRespons Function call
    // return VideoModel.fromJson(response);

    dynamic response = await _apiServices.getGetApiRespons(AppUrl.youtubeVideoApi+PassVideoUrl);             //* <-- getGetApiRespons Function call
    return VideoModel.fromJson(response);

  } catch (e) {
     throw e;
  }
 }







}