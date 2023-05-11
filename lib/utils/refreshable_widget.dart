import 'package:flutter/material.dart';

//Widget dùng cho sidebar navigation,khi đổi widget thì gọi callback
abstract class RefreshWidget extends StatelessWidget{
  void refreshCallback(){
  }
}