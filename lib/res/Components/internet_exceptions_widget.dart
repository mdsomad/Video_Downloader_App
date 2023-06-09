import 'package:flutter/material.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';






class InternetEexceptionWidget extends StatefulWidget {
  final VoidCallback onPress;
  const InternetEexceptionWidget({super.key, required this.onPress});

  @override
  State<InternetEexceptionWidget> createState() =>
      _InternetEexceptionWidgetState();
}

class _InternetEexceptionWidgetState extends State<InternetEexceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(
            height: height * .15,
          ),


          Icon(
            Icons.signal_wifi_connected_no_internet_4,
             color: AppColor.redColor.withOpacity(.8),
            size: 50,
          ),


          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
                child: Text(
              'Were unable tp show results.\n Please check your\n Internet Conenction.',
              textAlign: TextAlign.center,style: TextStyle(color: AppColor.white, fontSize: 18,fontWeight: FontWeight.bold),
            )),
          ),


          SizedBox(
            height: height * .12,
          ),




          InkWell(
            onTap: widget.onPress,
            child: Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                   color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                  child: Text("Retry",
                  style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black),
              )),
            ),
          )





        ],
      ),
    );
  }
}