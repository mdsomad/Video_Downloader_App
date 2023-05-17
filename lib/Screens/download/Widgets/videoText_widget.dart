import 'package:flutter/material.dart';

class VideoTextWidget extends StatelessWidget {
  const VideoTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: MediaQuery.of(context).size.width,
      color: Color(0xff009A2B),
      child: Center(
          child: Text(
        "AUDIO",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      )),
    );
  }
}
