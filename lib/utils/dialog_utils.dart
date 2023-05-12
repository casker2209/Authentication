import 'package:authentication/utils/color.dart';
import 'package:authentication/utils/go_router.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DialogUtils{
  static void showDialogError(BuildContext context,String message) {
    showDialog(
        context: context,
        builder: (context) => Center(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(0,18,0,36),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.error,size:30,color:UtilsColor.colorDarkRed),
                    SizedBox(height: 12),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: UtilsTextStyle.primaryTextStyle(color: Colors.black),
                    ),
                  ],
                ))));
  }


  static void showDialogLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)));
  }

  static void showDialogSuccess(BuildContext context,String message){
    showDialog(
        context: context,
        builder: (context) => Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(0,18,0,36),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/icon_success.png",height:30,width: 30,color:UtilsColor.colorGreenPrimary),
                    SizedBox(height: 12),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: UtilsTextStyle.primaryTextStyle(color: Colors.black),
                    ),
                  ],
                ))));
  }

  static void showCustomDialog(String message,{Widget? widgetTop,Widget? widgetBottom}){
    showDialog(
        context: GoRouterUtils.navState.currentContext!,
        builder: (context) => Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(0,18,0,36),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widgetTop ?? Container(),
                    SizedBox(height: 12),
                    Center(
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: UtilsTextStyle.primaryTextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 12),
                    widgetBottom ?? Container()
                  ],
                ))));
  }
}