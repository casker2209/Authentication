import 'package:flutter/painting.dart';

class UtilsTextStyle{
   static TextStyle? primaryTextStyle({double size = 16,required Color color,FontWeight? fontWeight,String? family}){
    return TextStyle(
      color: color,
      fontSize: size,
      fontFamily: family ?? "Inter",
      fontWeight: fontWeight ?? FontWeight.normal
    );
  }
}