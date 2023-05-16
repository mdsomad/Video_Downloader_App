


import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
          child: Text("PlayList Screen",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:AppColor.white),),
        ),
    );
  }
}