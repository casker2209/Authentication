import 'package:authentication/utils/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateUserScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Column(

          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(

              children: [
                Text("Họ tên"),
                Spacer(),
                SizedBox(
                  width: 200,
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: UtilsColor.colorGreenPrimary,width: 2)
                      )
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  "Danh bạ"
                )
              ],
            ),
            Row(

              children: [
                Text("SĐT"),
                Spacer(),
                SizedBox(
                  width: 200,
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: UtilsColor.colorGreenPrimary,width: 2)
                        )
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                    "Danh bạ"
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}