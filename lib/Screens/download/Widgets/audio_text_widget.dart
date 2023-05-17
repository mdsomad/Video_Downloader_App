import 'package:flutter/material.dart';

class AudioTextWidget extends StatelessWidget {
  const AudioTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      color: Color(0xff00599A),
      child: Center(
          child: const Text(
        "VIDEO",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      )),
    );
  }
}
