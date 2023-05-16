
import 'package:video_downloader_application/Models/Error_Model.dart';

class AppException implements Exception{
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString(){
    return '$_prefix$_message';
  }
  
}



class FetchDataException extends AppException{
  
  FetchDataException([String? message]):super (message, 'Error During Communication ');
  
}




class BadRequestException extends AppException{

  BadRequestException([ErrorModel? message]):super (message!.message.toString(), 'Invaild request ');
  
}



class UnauthorisedException extends AppException{

    UnauthorisedException([ErrorModel? message]):super (message!.message.toString(), '');
  
}



class InvaildInputException extends AppException{

  InvaildInputException([String? message]):super (message, 'Invaild input ');
  
}

class InternalServerErrorException extends AppException{
 
    InternalServerErrorException([ErrorModel? message]):super (message!.message.toString(), '');
  
}


class UnprocessableContentException extends AppException{

    UnprocessableContentException([ErrorModel? message]):super (message!.message.toString(), 'Unprocessable Content ');
  
}