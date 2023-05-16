import 'package:flutter/material.dart';
import 'package:system_alert_window/system_alert_window.dart';




// class DisplayOverOtherAppsScreen extends StatefulWidget {
//   const DisplayOverOtherAppsScreen({super.key});

//   @override
//   State<DisplayOverOtherAppsScreen> createState() => _DisplayOverOtherAppsScreenState();
// }

// class _DisplayOverOtherAppsScreenState extends State<DisplayOverOtherAppsScreen> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     getPermission();
//     super.initState();
//   }

//   getPermission()async{
//     await SystemAlertWindow.requestPermissions;
//   }
  
  
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center ,
//       children: [
//         Center(
//           child: TextButton(onPressed: (){
//             SystemAlertWindow.showSystemWindow(
//               backgroundColor: Colors.pink,
//               margin: SystemWindowMargin(left: 50),
//               gravity: SystemWindowGravity.BOTTOM,
//               header:SystemWindowHeader(
//                 title: SystemWindowText(text: "Hello akjhskhaskjhakshkah")
//               ),
//               height: 500
//             );
//           },child: Text("Flott"),),
//         ),
//         Center(
//           child: TextButton(onPressed: (){
//             SystemAlertWindow.closeSystemWindow();
//           },child: Text("Close windo"),),
//         )
//       ],
//     );
//   }
// }




class DisplayOverOtherAppsScreen extends StatefulWidget {
  const DisplayOverOtherAppsScreen({super.key});

  @override
  State<DisplayOverOtherAppsScreen> createState() => _DisplayOverOtherAppsScreenState();
}

class _DisplayOverOtherAppsScreenState extends State<DisplayOverOtherAppsScreen> {


OverlayEntry? entry;
Offset offset = Offset(20, 40);
  
  
  
  

  @override
  void initState() {
    // TODO: implement initState
     WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay());
    super.initState();
  }


@override
  void dispose() {
    // TODO: implement dispose
    hideOverlay();
    super.dispose();
  }
  


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center ,
        children: [
          Center(
            child: TextButton(onPressed: showOverlay,child: Text("Show Floating Widget"),),
          ),
          Center(
            child: TextButton(onPressed: hideOverlay,child: Text("Hide Floating Widget"),),
          ),
         
        ],
      ),
    ); 
    
    
  }


  void showOverlay (){
       entry = OverlayEntry(builder:(context) => Positioned(
        left: offset.dx,
        top: offset.dy,
        child: GestureDetector(
        onPanUpdate: (details) {
          offset += details.delta;

          entry!.markNeedsBuild();
          
        },
          child: ElevatedButton.icon(
            icon: Icon(Icons.stop_circle_rounded),
            label: Text("Record"),
            onPressed: (){
              print('Ckice');
            },),
        )));
    
      final overlay = Overlay.of(context);
      overlay.insert(entry!);
  }


  void hideOverlay(){
     entry?.remove();
     entry = null;
  }
    



  
}