import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Provider/home/home_provider.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';






class InputSearchWidget  extends StatelessWidget {
 final TextEditingController controller;
 final VoidCallback onPreass;
 final VoidCallback onClearPreass;
 final String controllerValueChack;

  const InputSearchWidget({super.key, required this.controller, required this.onPreass, required this.onClearPreass, required this.controllerValueChack});


  @override
  Widget build(BuildContext context) {
    return Container(
    height: 140,
    color: AppColor.appBarColor2,
    
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          
          
          controller: controller,
          // textInputAction:TextInputAction.next,
          textInputAction: TextInputAction.search,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            
            hintText: "Enter video link",
              
            suffixIcon:

            Container(
              // color: Colors.pink,
               padding: EdgeInsets.symmetric(horizontal: 0,vertical: 7),
               margin: EdgeInsets.only(right: 0),
              child: Row(
                 mainAxisSize: MainAxisSize.min,
                children: <Widget>[
               Provider.of<HomeProviderModel>(context,listen: false).controllerValueChack.isNotEmpty  ? 
              IconButton(
              icon: Icon(Icons.clear,color: Colors.white,),
              onPressed: onClearPreass,
              ):SizedBox(),
                  TextButton(
                    child: Icon(
                    Icons.search,color: Colors.white,size: 30),
                    style: ButtonStyle(overlayColor:
                    MaterialStateColor.resolveWith((states) =>Colors.white.withOpacity(0.1)),
                    shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(50.0),
                    ))),
                    onPressed:onPreass,
                  ),
                ],
              ),
            ),



            // Provider.of<HomeProviderModel>(context,listen: false).controllerValueChack.isNotEmpty  ? IconButton(onPressed: onClearPreass, icon:Icon(Icons.close,color: Colors.white,size: 30)) : IconButton(onPressed: onPreass, icon:Icon(Icons.search,color: Colors.white,size: 30)),
            //  Provider.of<HomeProviderModel>(context,listen: false).controllerValueChack.isNotEmpty  ? IconButton(onPressed: onClearPreass, icon:Icon(Icons.close,color: Colors.white,size: 30)) : IconButton(onPressed: onPreass, icon:Icon(Icons.search,color: Colors.white,size: 30)),
            // suffixIcon: Icon(Icons.search,color: Colors.white,size: 30,),

            enabledBorder: OutlineInputBorder(
               borderSide: BorderSide(width: 2, color: AppColor.white), //<-- SEE HERE
            ),

            focusedBorder: OutlineInputBorder(
               borderSide: BorderSide(width: 2, color: Colors.amberAccent),
            ),
            
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
               borderSide: const BorderSide(color: Colors.white,),
            ),
            hintStyle: TextStyle(
              color: Colors.white
            ),
          
            
          ),

          onChanged: (value) {
            Provider.of<HomeProviderModel>(context,listen: false).setcontrollerValueChack(value);
            print(value);
          },
          
        ),
      ),
    ),
  );
  }
}