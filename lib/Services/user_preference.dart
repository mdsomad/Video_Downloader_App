import 'package:shared_preferences/shared_preferences.dart';






class UserPreference {


//TODO Create saveUser function
Future<bool> saveUser(dynamic responseModel)async{                        //* <-- This function currently not use
   SharedPreferences sp = await SharedPreferences.getInstance();
   sp.setString("token", responseModel.token.toString());
   sp.setBool("isLogin", responseModel.isLogin!);
   
    return true;

  }



//TODO Create getUser function
Future<dynamic> getUser()async{                                    //* <-- This function currently not use
   SharedPreferences sp = await SharedPreferences.getInstance();
   String? token = sp.getString("token");
   bool? isLogin = sp.getBool("isLogin");
   
    return token;
  }






//TODO Create removeUser function
Future<bool> removeUser()async{                                          //* <-- This function currently not use
   SharedPreferences sp = await SharedPreferences.getInstance();
   sp.clear();
   return true;
}
  
  
  
  
  
  
  
   
}






   