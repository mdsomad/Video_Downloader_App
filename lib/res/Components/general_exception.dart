import 'package:flutter/material.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';










class GeneralEexceptionWidget extends StatefulWidget {
  final VoidCallback onPress;
  const GeneralEexceptionWidget({super.key, required this.onPress});

  @override
  State<GeneralEexceptionWidget> createState() =>
      _GeneralEexceptionWidgetState();
}

class _GeneralEexceptionWidgetState extends State<GeneralEexceptionWidget> {
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
            Icons.cloud_off,
             color: AppColor.redColor,
            size: 50,
          ),


          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
                child: Text(
              'general_exception',
              textAlign: TextAlign.center,
            )),
          ),


          SizedBox(
            height: height * .15,
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
                    .copyWith(color: Colors.white),
              )),
            ),
          )





        ],
      ),
    );
  }
}