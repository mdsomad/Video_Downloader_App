


import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_application/Provider/download/DownloadProvider.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({Key? key}) : super(key: key);

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("PlayList Screen",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:AppColor.white),),
              TextButton(onPressed: (){
                var settingsProvider = Provider.of<DownloadProviderPress>(context,listen:false);
                settingsProvider.download(0);
              }, child:Text("Click"))
            ],
          ),
        ),
    );
  }
}