import 'package:authentication/bloc/splash/splash_bloc.dart';
import 'package:authentication/bloc/splash/splash_event.dart';
import 'package:authentication/bloc/splash/splash_state.dart';
import 'package:authentication/utils/color_utils.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:authentication/utils/dialog_utils.dart';

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create:(context) => SplashBloc()..add(SplashEvent()),
      child: BlocConsumer<SplashBloc,SplashState>(
        listener: (context,state){
            if (state.success) {
              context.go("/home");
            }
            else {
              DialogUtils.showDialogError(context, state.message);
              context.go("/authentication");
            }
        },
        listenWhen: (state1,state2) => state1.loading == true && state2.loading == false,
        builder:(context,state) => Scaffold(
          backgroundColor: ColorUtils.colorGreenPrimary,
          body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:200,width: double.infinity,),
                Image.asset("assets/images/icon_splash.png",height: 110,width: 110),
                SizedBox(height: 40),
                Text(
                  "Private Chat",style: TextStyleUtils.robotoTextStyle(color: Colors.white,size: 40,fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 50),
            Text(
              "Ứng dụng hỗ trợ",style: TextStyleUtils.robotoTextStyle(color: Colors.white,size: 40,fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 40),
            Container(height: 25,width: 25,child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
              ]
            ),
        ),
      ),
    );
  }

}