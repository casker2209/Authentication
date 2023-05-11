import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DialogUtils{
  static void showDialogError(BuildContext context,String message) {
    showDialog(
        context: context,
        builder: (context) => Center(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                color: Colors.white,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: UtilsTextStyle.primaryTextStyle(color: Colors.black),
                ))));
  }


  static void showDialogLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)));
  }
}