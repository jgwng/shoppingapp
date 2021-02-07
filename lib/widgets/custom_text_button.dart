import 'package:flutter/material.dart';


const Set<MaterialState> interactiveStates = <MaterialState>{
  MaterialState.pressed,
  MaterialState.hovered,
  MaterialState.focused,
  MaterialState.dragged,
  MaterialState.disabled,
  MaterialState.selected,
};

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color foregroundColor;
  final Color pressedForegroundColor;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Color pressedBackgroundColor;

  const CustomTextButton({this.foregroundColor, this.pressedForegroundColor, this.textStyle, this.text, this.backgroundColor, this.pressedBackgroundColor, this.onPressed});
  TextStyle getTextStyle(Set<MaterialState> states) {
    return textStyle;
  }
  Color getBackgroundColor(Set<MaterialState> states) {
    if (states.any(interactiveStates.contains)) {
      return pressedBackgroundColor != null ? pressedBackgroundColor : backgroundColor;
    }
    return backgroundColor;
  }
  Color getForegroundColor(Set<MaterialState> states){
    if (states.any(interactiveStates.contains)) {
      return pressedForegroundColor != null ? pressedForegroundColor : foregroundColor;
    }
    return foregroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text), style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith(
          getForegroundColor),
      backgroundColor: MaterialStateProperty.resolveWith(
          getBackgroundColor),
      textStyle:  MaterialStateProperty.resolveWith(
          getTextStyle),
    ),);
  }
}
