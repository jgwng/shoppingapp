import 'package:flutter/cupertino.dart';

class MyBehavior extends ScrollBehavior{
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => ClampingScrollPhysics();

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}