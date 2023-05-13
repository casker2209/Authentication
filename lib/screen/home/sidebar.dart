import 'package:authentication/bloc/home/home_bloc.dart';
import 'package:authentication/bloc/home/home_event.dart';
import 'package:authentication/bloc/home/home_state.dart';
import 'package:authentication/network/local/local_data_utils.dart';
import 'package:authentication/network/response/get_me.dart';
import 'package:authentication/utils/color_utils.dart';
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
             decoration: const BoxDecoration(
              color: ColorUtils.colorGreenPrimary
             ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
              children: [
                const SizedBox(height:80),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/icon_white_bubble.png",height: 45,width: 45),
                    SizedBox(width: 18),
                    Text(response!=null ? response!.name! : "",style: TextStyleUtils.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w600,size:16))
                  ],
                ),
              Spacer(),
              InkWell(
                onTap: (){
                  LocalDataUtils.clearLogin();
                  context.go("/authentication");
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_outlined,size: 20),
                    SizedBox(width: 35),
                    Text("Đăng xuất",style: TextStyleUtils.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w500,size:14))
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
              _textWithIcon(0,Icons.notifications_sharp, "Private Chat",context),
              _textWithIcon(1,Icons.person, "Quản lý khách hàng",context),
              _textWithIcon(2,Icons.key, "Đổi mật khẩu",context),
            ],
          ),
        )
      ],
    );
  }

  Widget _textWithIcon(int index,IconData icon,String text,BuildContext blocContext){
    HomeState state =  BlocProvider.of<HomeBloc>(blocContext).state;
    return InkWell(
      onTap: (){
        Navigator.of(blocContext).pop();
        BlocProvider.of<HomeBloc>(blocContext).add(IndexChangedEvent(index));
      },
      child: Container(padding: EdgeInsets.symmetric(vertical: 12,horizontal: 20),
      color: state.index != index ? Colors.white : ColorUtils.colorLightGrey,
      child: Row(
        children: [
          Icon(icon,size: 16,color: state.index != index ? Colors.black : ColorUtils.colorGreenPrimary,),
          SizedBox(width: 35),
          Text(text,style: TextStyleUtils.primaryTextStyle(color: state.index != index ? ColorUtils.colorGrey3 : ColorUtils.colorGreenPrimary,))
        ],
      ),
      ),
    );
  }
}