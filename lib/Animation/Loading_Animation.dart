import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';






class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Center(
        child: SizedBox(
          width: 300.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
                 DNA(index: 20,color: Colors.yellow,),
                 DNA(index: 18,color: Colors.orange,),
                 DNA(index: 16,color: Colors.pink,),
                 DNA(index: 14,color: Colors.red,),
                 DNA(index: 12,color: Colors.purple,),
                 DNA(index: 10,color: Colors.purple,),

                 DNA(index: 8,color: Colors.red,),
                 DNA(index: 6,color: Colors.pink,),
                 DNA(index: 4,color: Colors.orange,),
                 DNA(index: 2,color: Colors.amber,),
                 DNA(index: 2,color: Colors.amber,),
                 DNA(index: 4,color: Colors.orange,),
                 DNA(index: 6,color: Colors.pink,),
                 DNA(index: 8,color: Colors.red,),

                 DNA(index: 10,color: Colors.purple,),
                 DNA(index: 12,color: Colors.purple,),
                 DNA(index: 14,color: Colors.red,),
                 DNA(index: 16,color: Colors.pink,),
                 DNA(index: 18,color: Colors.orange),
                 DNA(index: 20,color: Colors.amber,),
            ],
          ),
        ),
      ),
                        
    );
  }
}








class DNA extends StatefulWidget {
  final int index;
  final Color color;
  const DNA({Key? key,required this.index,required this.color}) : super(key: key);

  @override
  State<DNA> createState() => _DNAState();
}

class _DNAState extends State<DNA> with SingleTickerProviderStateMixin {

  late AnimationController  _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync:this , duration: const Duration(milliseconds:800 ));
    _scaleAnimation = Tween<double>(begin: 2.0,end: 50.0).animate(CurvedAnimation(parent: _animationController,curve:Curves.easeInOut));


    Future.delayed(Duration(milliseconds: widget.index * 80 ),(){
      _animationController.forward();
    });

    _animationController.addListener(() { 
      if(_animationController.isCompleted){
        _animationController.reverse();
      }else if(_animationController.isDismissed){
        _animationController.forward();
      }
    });
    
    super.initState();

  }






@override
dispose() {
  _animationController.dispose(); // you need this
  super.dispose();
}
  
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Container(
            height: _scaleAnimation.value,
            width: 8.0,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(5.0)
            ),
          );
        }
      ),
    );
  }
}