import 'package:authentication/utils/color_utils.dart';
import 'package:authentication/utils/go_router.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';

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
                    Icon(Icons.error,size:30,color:ColorUtils.colorDarkRed),
                    SizedBox(height: 12),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyleUtils.primaryTextStyle(color: Colors.black),
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
                    Image.asset("assets/images/icon_success.png",height:30,width: 30,color:ColorUtils.colorGreenPrimary),
                    SizedBox(height: 12),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyleUtils.primaryTextStyle(color: Colors.black),
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
                        style: TextStyleUtils.primaryTextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 12),
                    widgetBottom ?? Container()
                  ],
                ))));
  }

  static void showButtonDialog({String? title,String? message,String titleButton = "OK",Function? onClick}){
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
                    title==null ? Container() : Text(title
                      ,style: TextStyleUtils.primaryTextStyle(color: Colors.black,fontWeight: FontWeight.w700,size: 16)),
                    title == null ? Container() : const SizedBox(height: 12),
                    message == null ? Container() : Center(
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyleUtils.primaryTextStyle(color: Colors.black),
                      ),
                    ),
                    message == null? Container() : SizedBox(height:12),
                    Center(
                     child:Material(
                       child: InkWell(
                         onTap:(){
                           if(onClick!=null) onClick!.call();
                         },
                         child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorUtils.colorGreenPrimary
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 36),
                             child: Text(titleButton,style:TextStyleUtils.primaryTextStyle(color: Colors.white
                             ))),
                       ),
                     ),
                    )
                  ],
                ))));
  }
}