import 'package:flutter/painting.dart';

class UtilsTextStyle{
   static TextStyle primaryTextStyle({double size = 16,double? height,required Color color,FontWeight? fontWeight,String? family}){
    return TextStyle(
      color: color,
      fontSize: size,
      fontFamily: family ?? "Inter",
      fontWeight: fontWeight ?? FontWeight.normal,
      height: height
    );
  }
   static TextStyle? robotoTextStyle({double size = 16,required Color color,FontWeight? fontWeight}) {
     return TextStyle(
         color: color,
         fontSize: size,
         fontFamily: "Roboto",
         fontWeight: fontWeight ?? FontWeight.normal
     );
   }
}
