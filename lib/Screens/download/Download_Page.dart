// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Models/Video_Model.dart';
import 'package:video_downloader_application/Provider/Download_Dio_provider.dart';
import 'package:video_downloader_application/Provider/home_provider.dart';
import 'package:video_downloader_application/Video_DownladFiles/check_permission.dart';





class DownloadPage extends StatefulWidget {
  var filterVideosList;
  List<VideoModel> videoList;
  DownloadPage({
    Key? key,
    required this.filterVideosList,
    required this.videoList,
  }) : super(key: key);
   

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {


//  bool isPermission = false;
//  var checkALlPermissions = CheckPermission();

//  checkPermission()async{
//     var permission = await checkALlPermissions.idStoragePermission();
//     if(permission){
//       setState(() {
//         isPermission = true;
//       });
//     }
    
//  }

  @override
  void initState() {
    // TODO: implement initState
    // checkPermission();
     Provider.of<DownloadProvider>(context,listen:false).checkPermission();

    //  if(Provider.of<DownloadProvider>(context,listen:false).isPermission){
    //       Provider.of<DownloadProvider>(context,listen:false).checkFileExit();
    //       Provider.of<DownloadProvider>(context,listen:false).startDownloading(widget.filterVideosList,widget.videoList,context);
    //  };
    
     if(widget.filterVideosList.url != null || widget.filterVideosList.url != ""){
         Provider.of<DownloadProvider>(context,listen:false).checkFileExit();
        //  Provider.of<DownloadProvider>(context,listen:false).startDownloading(widget.filterVideosList,widget.videoList,context);
     }
    
      
     super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
      return  Consumer<DownloadProvider>(  //* <-- Provider Use
        builder: (context, provider, child) {
        return  Scaffold(
         body: SafeArea( 
           child: provider.isPermission ? Container(
            // color: Colors.pink,
            height:MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: (){
                      provider.fileExist &&  provider.downloading == false ?  provider.openfile():
                      provider.cancelDownlad();
                    },icon: provider.fileExist &&  provider.downloading == false ? Icon(Icons.window,color: Colors.green,) : Icon(Icons.close),),
                    Container(
                     color: Colors.pink,
                     height: 6.5,
                     width: 300,
                    //  margin: EdgeInsets.symmetric(horizontal: 30),
                      child: LinearProgressIndicator(
                      //  value: 0.6,
                       value: provider.progress,
                       minHeight: 5,
                       valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
                       backgroundColor: Color(0xffD6D6D6),
                     ),
                    ),

        IconButton(onPressed: (){
          //  provider.fileExist &&  provider.downloading == false 
          // ?  provider.openfile()
          // : provider.startDownloading(widget.filterVideosList,widget.videoList,context);
        },
        icon:
         provider.fileExist ? Icon(Icons.save,color: Colors.green,) :
          provider.downloading ? Stack(
          alignment: Alignment.center,
          children: [
                  Text("${(provider.progress * 100).toInt().toString()}",style: TextStyle(fontSize: 12),)
                  // Text("${( provider.progress*100).toStringAsFixed(2)}",style: TextStyle(fontSize: 12),)
          ],
         ):

         Icon(Icons.download) ,
        
        
        )
         
                    // Text((provider.progress*100).toInt().toString(),style: TextStyle(fontSize:30),),
                    
                    
                  ],
                ),
              ],
            ),
            
            
            
            // child: Flex(
            // direction: Axis.horizontal,
            //  children: [
           
           
            //  SizedBox(height: 20,),
            //  Padding(
            //    padding: const EdgeInsets.symmetric(horizontal: 50),
            //    child: LinearProgressIndicator(
            //    value: provider.progress,
            //    minHeight: 5,
            //    valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
            //    backgroundColor: Color(0xffD6D6D6),
            //  ),
            //  ),
               
               
                     
            //  ],
            // )),
           )
           
           
           : Center(child: TextButton(onPressed: (){
              provider.checkPermission();
              }, child: Text("Permission issue")))




         ),
          // floatingActionButton: FloatingActionButton(onPressed: (){
          //   if(provider.downloading == true){
          //     provider.cancelDownlad();
          //   }else{
          //    provider.fileExist && provider.downloading == false ? provider.openfile() : provider.startDownloading(widget.url, context);
          //   }
          // },child: provider.fileExist ? Icon(Icons.save) : Icon(Icons.download)),
          
          
          
      ) ;
        }
       );
       


  }
}

