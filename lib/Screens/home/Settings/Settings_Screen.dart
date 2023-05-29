
import 'package:flutter/material.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';




class SettingsScreen extends StatelessWidget {
  const SettingsScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: Text("Settings"),
        
      ),

      body: Container(
        color: AppColor.bodyColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child: Column(
        
            children: [
              Row(
                children: [
                  Text("Downloading",style: TextStyle( color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  Spacer(),
                  Switch(value:false, onChanged: (value) {
                    
                  },)
                  
                  
                ],
              )
              
            ],
            
          ),
        )),
      
      
    );
  }
}