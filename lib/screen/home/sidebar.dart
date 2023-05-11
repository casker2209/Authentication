import 'package:authentication/bloc/home/home.dart';
import 'package:authentication/bloc/home/home_event.dart';
import 'package:authentication/network/get_me.dart';
import 'package:authentication/utils/color.dart';
import 'package:authentication/utils/shared_preferences_utils.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget{
  GetMeResponse? response;
  Sidebar(this.response);
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(height: 320,
          child: DrawerHeader(
             decoration: BoxDecoration(
              color: UtilsColor.colorGreenPrimary
             ),
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
              children: [SizedBox(height:80),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/icon_white_bubble.png",height: 45,width: 45),
                    SizedBox(width: 18),
                    Text(response!=null ? response!.name! : "",style: UtilsTextStyle.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w600,size:16))
                  ],
                ),
              Spacer(),
              InkWell(
                onTap: (){
                  SharedPreferencesUtils.clearLogin();
                  context.go("/authentication");
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_outlined,size: 20),
                    SizedBox(width: 35),
                    Text("Đăng xuất",style: UtilsTextStyle.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w500,size:14))
                  ],
                ),
              ),
                SizedBox(height:25)
              ],
          )),
        ),
        Expanded(
          child: Column(
            children: [
              TextWithIcon(0,Icon(Icons.notifications_sharp,size:16), "Private Chat",context),
              TextWithIcon(1,Icon(Icons.person,size:16), "Quản lý khách hàng",context),
              TextWithIcon(2,Icon(Icons.key,size:16), "Đổi mật khẩu",context),
            ],
          ),
        )
      ],
    );
  }

  Widget TextWithIcon(int index,Widget image,String text,BuildContext blocContext){
    return InkWell(
      onTap: (){
        Navigator.of(blocContext).pop();
        BlocProvider.of<HomeBloc>(blocContext).add(IndexChangedEvent(index));
      },
      child: Container(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      color: Colors.white,
      child: Row(
        children: [
          image,
          SizedBox(width: 35),
          Text(text,style: UtilsTextStyle.primaryTextStyle(color: UtilsColor.colorGrey3))
        ],
      ),
      ),
    );
  }
}