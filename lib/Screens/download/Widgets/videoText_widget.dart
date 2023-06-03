import 'package:flutter/material.dart';

class VideoTextWidget extends StatelessWidget {
  final String title;
   VideoTextWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: MediaQuery.of(context).size.width,
      color: Color(0xff009A2B),
      child: Center(
          child: Text(
        title.toString() == 'mp4' ? "VIDEO":'AUDIO',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      )),
    );
  }
}
