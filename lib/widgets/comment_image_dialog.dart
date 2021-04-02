import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vc;
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';

class CommentImageDialog extends StatefulWidget{
  @override
  _CommentImageDialogState createState() => _CommentImageDialogState();
}

class _CommentImageDialogState extends State<CommentImageDialog> with SingleTickerProviderStateMixin{
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController= new AnimationController(vsync: this,  duration: Duration(milliseconds:500));
    _animation = Tween(begin: 1.0,end: 3.0).animate(CurvedAnimation(parent: _animationController,curve: Curves.easeInOut))..addListener(() {
      setState(() {

      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.75),
       appBar: AppBar(
         backgroundColor:  Colors.black.withOpacity(0.75),
         leading: GestureDetector(
           onTap: () => Navigator.pop(context),
           child: Icon(Icons.clear,size: 20,color: Colors.white,),
         ),
         title: Text("후기 사진",style: TextStyle(fontSize: 20,color: Colors.white),),
       ),
       body : GestureDetector(
         behavior: HitTestBehavior.opaque,
         onTap: () => Navigator.pop(context),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(height: 60,),
             GestureDetector(
               onDoubleTap: (){
                 if(_animationController.isCompleted){
                    _animationController.reverse();
                 }else{
                   _animationController.forward();
                 }
               },
               child: Container(
                   height: 380,
                   alignment: Alignment.center,
                   child: Center(
                     child: SizedBox(
                       width: size.width,
                       height: 380,
                       child: Transform(
                         alignment: FractionalOffset.center,
                         transform: Matrix4.diagonal3(vc.Vector3(_animation.value,_animation.value,_animation.value)),
                        child: Image.asset("assets/images/category_icon/hoodie.png",fit: BoxFit.fitHeight),
                       ),
                     ),
                   )
               )
             ),
             SizedBox(height: 80,),
             Text("후기 내용이 들어갈 자리입니다.",style: AppThemes.textTheme.bodyText1.copyWith(color: Colors.white),)
           ],
         ),
       )
    );
  }


}