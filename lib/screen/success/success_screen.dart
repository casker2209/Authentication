import 'package:authentication/utils/color.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SuccessScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go("/home");
        return false;
        //Làm giống khi bấm hoàn thành
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body:Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 80),
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                   "assets/images/icon_success.png",width: 100,height: 100,
                  ),
                  SizedBox(height:10),
                  Text("Thành Công!",
                      textAlign: TextAlign.center,
                      style:UtilsTextStyle.primaryTextStyle(color: UtilsColor.colorGreenPrimary,fontWeight: FontWeight.w700,size: 32)),
                  SizedBox(height:10),
                  Text("Chúc mừng bạn đã đăng ký thành công tài khoản trên ứng dụng di động.",style:UtilsTextStyle.primaryTextStyle(color: Colors.black,fontWeight: FontWeight.w500,size: 18)),
                  SizedBox(height:50),
                  InkWell(
                    onTap: (){
                      context.push("/home");
                    },
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: UtilsColor.colorGreenPrimary
                        ),
                        child: Text("Hoàn thành",
                            textAlign: TextAlign.center,
                            style:UtilsTextStyle.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w600,size: 18))),
                  )
                ],
              ),
            ),
        ),
      ),
    );
  }

}