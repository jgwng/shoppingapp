import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/grocery-cart.png'),
            SizedBox(height: 12.5,),
          ],
        ),
      ),
    );
  }
}
