import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_downloader_application/Screens/home/Settings/Settings_Screen.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';



class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {


  final List drawerMenuListname = const [
    {
      "leading": Icon(
        Icons.settings,
        color: Color(0xFF13C0E3),
      ),
      "title": "Settings",
      "trailing": Icon(Icons.chevron_right,color: AppColor.white,),
      "action_id": 1,
    },
  ];
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.bodyColor,
      child: ListView(
        children: [

             ...drawerMenuListname.map((sideMenuData){
                return ListTile(
                    leading: sideMenuData['leading'],
                    title:Text(sideMenuData['title'],style: TextStyle(color: Colors.white),),
                    trailing: sideMenuData['trailing'],
                    


                    onTap: (){
                      Navigator.pop(context);
                      if(sideMenuData["action_id"] == 1){
                        Navigator.push(context,MaterialPageRoute(builder:
                         ((context) =>SettingsScreen())));
                      }

                      else if(sideMenuData["action_id"] == 4){
                            // Navigator.push(context,
                            // MaterialPageRoute(builder: 
                            // ((context) =>SettingScreen() )));


                      }
                    },
                );
              }).toList()
          
        ],
        )
    );
  }





}




