// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Data/response/api_response.dart';
import 'package:video_downloader_application/Models/Video_Model.dart';
import 'package:video_downloader_application/Provider/Download_Dio_provider.dart';
import 'package:video_downloader_application/Screens/download/Widgets/videoText_widget.dart';
import 'package:video_downloader_application/Screens/download/Widgets/video_download_display_widget.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';





class DownloadPage2 extends StatefulWidget {
  var filterVideosList;
 ApiResponse<VideoModel> videoList;
   DownloadPage2({
    Key? key,
    required this.filterVideosList,
    required this.videoList,
  }) : super(key: key);

  @override
  State<DownloadPage2> createState() => _DownloadPage2State();
}

class _DownloadPage2State extends State<DownloadPage2> {


  @override
  void initState() {
    // TODO: implement initState
    Provider.of<DownloadProvider>(context,listen:false).checkPermission();

    
      if(Provider.of<DownloadProvider>(context,listen:false).isPermission == true){
            Provider.of<DownloadProvider>(context,listen:false).checkFileExit();
            Provider.of<DownloadProvider>(context,listen:false).startDownloading(widget.filterVideosList,widget.videoList,context);
      }

    super.initState();
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          elevation: 7,
          title: Container(
              // color: Colors.yellow,
              padding: EdgeInsets.only(bottom: 15),
              child: Image.asset("Assets/AppIcons/Frame.png")),
          // toolbarHeight: 30,


        ),
        body:Consumer<DownloadProvider>(  //* <-- Provider Use
        builder: (context, provider, child) {
        return 

        provider.isPermission ? Center(
          child: Column(
            children: [
              VideoTextWidget(),

              VideoDownloadDisplayWidget(provider: provider,filterVideosList: widget.filterVideosList, videoList: widget.videoList, press: () { 

                 provider.fileExist && provider.downloading == false 
                 ? provider.openfile()
                 : provider.startDownloading(widget.filterVideosList,widget.videoList,context);
                
               },),
            
              
              
              
        
              
              
              // context),
              // audioText(context),
             
              // Text("Downlad Screen",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:AppColors.white)),
            ],
          ),
        ):Center(child: TextButton(onPressed: (){
              provider.checkPermission();
              }, child: Text("Permission issue")))
 ;
        })

    );
  }
}