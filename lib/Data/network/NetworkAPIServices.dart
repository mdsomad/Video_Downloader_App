
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:video_downloader_application/Data/app_expositions.dart';
import 'package:video_downloader_application/Data/network/BaseApiServices.dart';
import 'package:video_downloader_application/Models/error/Error_Model.dart';

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
  Future getPostApiRespons(String url, var data) async {
    // TODO: implement getPostApiRespons
   

     if(kDebugMode){
      print("This Url --> $url");
      print("This Data --> $data");
     
    }
    
    
    dynamic responseJson;
    try {
       final response = await http.post(Uri.parse(url),
             headers: {
                'Content-Type': 'application/json',
                "Accept": "application/json",
              },
          body: jsonEncode(data)    //* <-- Agar row form mein Data Hai To Aise Hi bhejna hai
          //  body:data              //* <-- Agar from-data hai to Aise Hi bhejna hai  
                
       ).timeout( const Duration(seconds: 60));

       responseJson = returnResponse(response); //* <-- Call this returnResponse  Function

    } on SocketException{
      throw FetchDataException('No Internet Conncetion');
    }
    
    if(kDebugMode){
      print(responseJson);
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

