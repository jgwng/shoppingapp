import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,

              child: Image.asset('assets/logo/grocery-cart.png',fit: BoxFit.fill,),
            ),

          ],
        ),
      ),
    );
  }
}
