import 'package:flutter/painting.dart';

class UtilsTextStyle{
   static TextStyle? primaryTextStyle({double size = 16,required Color color,FontWeight? fontWeight}){
    return TextStyle(
      color: color,
      fontSize: size,
      fontFamily: "Inter",
      fontWeight: fontWeight ?? FontWeight.normal
    );
  }
}