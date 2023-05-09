import 'package:authentication/screen/account_list/account_list_screen.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 23,

        title: Row(
          children: [

            InkWell(child: Icon(Icons.menu,color: Colors.white,size: 16),
              onTap: () {

              },
            ),
            SizedBox(width: 30),
            Text("Quản lý khách hàng",
              style: UtilsTextStyle.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w600,size: 20),
            ),
            Spacer(),
            Text("11/11/2022",
              style: UtilsTextStyle.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w600,size: 16,
                  family:"Roboto"),
            )
          ],
        ),
      ),
      body: IndexedStack(
        index: 0,
        children: [
          AccountListScreen()
        ],
      ),
    );
  }
}