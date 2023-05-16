
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:video_downloader_application/Data/app_expositions.dart';
import 'package:video_downloader_application/Data/network/BaseApiServices.dart';
import 'package:video_downloader_application/Models/Error_Model.dart';

class NetworkApiServices extends BaseAPIServices{   //* NetworkApiServices class Link this BaseAPIServices class


  @override
  Future getGetApiRespons(String Url) async{
    // TODO: implement getGetApiRespons

    dynamic responseJson;
    try {

      final response = await http.get(Uri.parse(Url)).timeout(Duration(seconds: 60));

      responseJson = returnResponse(response);         //* <-- returnResponse Finction call
      
    } on SocketException {
      throw FetchDataException('No Internet Conncetion');  //* <-- FetchDataException class call
    }
    return responseJson;
    
    
  }







  @override 
  Future getPostApiRespons(String url,dynamic data)async {      //* <-- getPostApiRespons function call
    // TODO: implement getPostApiRespons
    
   dynamic responseJson;
    try {
     Response response = await post(
      Uri.parse(url),
      body: data

     ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);    //* <-- returnResponse Finction call
    } on SocketException {
      throw FetchDataException('No Internet Conncetion');
    }
    return responseJson;
  }












// TODO returnResponse Function Create
dynamic returnResponse (http.Response response){

  switch(response.statusCode){
      case 200:
       dynamic responseJson = jsonDecode(response.body);
       return responseJson;
      case 400:
        throw BadRequestException(ErrorModel.fromJson(jsonDecode(response.body)));   //* <-- BadRequestException class Call
      case 500:
        throw InternalServerErrorException(ErrorModel.fromJson(jsonDecode(response.body)));   //* <-- InternalServerErrorException class Call
      case 404:
       throw UnauthorisedException(ErrorModel.fromJson(jsonDecode(response.body)));   //* <-- UnauthorisedException class Call
      case 422:
       throw UnprocessableContentException(ErrorModel.fromJson(jsonDecode(response.body)));   //* <-- UnauthorisedException class Call
      default :
       throw FetchDataException(' Error accured white communicating with server '+   //* <-- FetchDataException  class Call
              'with status code' + response.statusCode.toString());
     }
  
  
}


  

}

