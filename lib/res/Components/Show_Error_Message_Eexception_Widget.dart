import 'package:flutter/material.dart';
import 'package:video_downloader_application/res/Colors/app_colors.dart';






class ShowErrorMessageEexceptionWidget extends StatefulWidget {
  final VoidCallback onPress;
  final String errorMessage;
  const ShowErrorMessageEexceptionWidget({super.key, required this.onPress, required this.errorMessage});

  @override
  State<ShowErrorMessageEexceptionWidget> createState() =>
      _ShowErrorMessageEexceptionWidgetState();
}

class _ShowErrorMessageEexceptionWidgetState extends State<ShowErrorMessageEexceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return  Padding(
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
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
                widget.errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25,color: AppColor.redColor,fontWeight: FontWeight.bold),
                          ),
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
                    .copyWith(color: Colors.black),
              )),
            ),
          )
     
     
     
     
     
        ],
      ),
       );





    
  }
}