// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:video_downloader_application/Data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
  String? nodata;
 

  ApiResponse(
    this.status,
    this.data,
    this.message,
    this.nodata,
  );

 ApiResponse.loading() : status = Status.LOADING;

 ApiResponse.isEmpty(this.nodata) : status = Status.ISEMPTY;

 ApiResponse.completed(this.data) : status = Status.COMPLETED;

 ApiResponse.error(this.message) : status = Status.ERROR;
 

 @override
 String toString(){
   return "Status : $status \n Message : $message  \n Nodata : $nodata \n Data : $data";
 }
  
}