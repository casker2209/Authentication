import 'package:authentication/bloc/home/home_bloc.dart';
import 'package:authentication/bloc/home/home_event.dart';
import 'package:authentication/bloc/home/home_state.dart';
import 'package:authentication/screen/account_list/account_list_screen.dart';
import 'package:authentication/screen/change_password/change_password_screen.dart';
import 'package:authentication/screen/home/sidebar.dart';
import 'package:authentication/utils/color_utils.dart';
import 'package:authentication/utils/refreshable_widget.dart';
import 'package:authentication/utils/shared_preferences_utils.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget{
  List<RefreshWidget> widgetList =  [
    RefreshAccountListScreen(),
    RefreshAccountListScreen(),
    ChangePasswordScreen()
  ];
  List<String> tag = const ["Quản lý mật khẩu","Private Chat","Đổi mật khẩu"];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => HomeBloc(0)..add(GetMeEvent()),
      child: BlocConsumer<HomeBloc,HomeState>(
        listener: (context,state){
          widgetList[state.index]..refreshCallback();
        },
        listenWhen: (state1,state2) => state1.index != state2.index,
        builder:(context,state) => Scaffold(
          drawer: Drawer(child:
          Sidebar(state.response)),
          appBar: AppBar(
            titleSpacing: 23,
            title: Row(
              children: [
                Text(tag[state.index],
                  style: TextStyleUtils.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w600,size: 20),
                ),
                Spacer(),
                state.index != 2 ? Text("11/11/2022",
                  style: TextStyleUtils.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w600,size: 16,
                      family:"Roboto")) : Container()
              ],
            ),
          ),
          body: widgetList[state.index],
            floatingActionButton: state.index == 0 ? FloatingActionButton(
              onPressed: () {
                context.push("/create");
              },
              backgroundColor: ColorUtils.colorGreenPrimary,
              child: Icon(Icons.add),
            ) : null
        ),
      ),
    );
  }
}