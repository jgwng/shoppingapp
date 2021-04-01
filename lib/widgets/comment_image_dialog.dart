import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';

class CommentImageDialog extends StatefulWidget{
  @override
  _CommentImageDialogState createState() => _CommentImageDialogState();
}

class _CommentImageDialogState extends State<CommentImageDialog>{

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
             Container(
                 height: 380,
                 alignment: Alignment.center,
                 child: Center(
                   child: SizedBox(
                     width: size.width,
                     height: 380,
                     child: Image.asset("assets/images/category_icon/hoodie.png",fit: BoxFit.fitHeight),
                   ),
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