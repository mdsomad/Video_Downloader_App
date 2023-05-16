

//TODOclass abstract Create
abstract class BaseAPIServices {                //* <-- Link this calss NetworkApiServices
  Future<dynamic> getGetApiRespons(String url);
  Future<dynamic> getPostApiRespons(String url,dynamic data);
  // Future<dynamic> getGetBearerApiRespons(String url,String Token);
}