import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import '../../bloc/authentication_bloc.dart';
import '../../utils/Color.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(lazy:false,create: (context) => AuthenticationBloc())
        ],
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/images/logo.png"),
                ),
                Center(
                  child: Text(
                    "Smart Message",
                    textAlign: TextAlign.center,
                    style: UtilsTextStyle.primaryTextStyle(
                        color: UtilsColor.colorGreenPrimary,fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 85),
                Text(
                  "Xin Chào",
                  textAlign: TextAlign.start,
                  style: UtilsTextStyle.primaryTextStyle(
                    color: UtilsColor.colorGreenPrimary,
                    size: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height:5),
                Text(
                  "Đăng nhập để tiếp tục",
                  textAlign: TextAlign.start,
                  style: UtilsTextStyle.primaryTextStyle(
                    color: UtilsColor.colorGreenPrimary,
                    fontWeight: FontWeight.w500,
                    size: 19,
                  ),
                ),
                const SizedBox(height: 30),
                AuthenticationForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthenticationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.loading) {
          showDialogLoading(context);
        } else {
          Navigator.of(context).pop();
          if (state.response != null) {
            showDialogSucces(context);
          }
          if(state.success == false){
            showDialog(context: context, builder: (context) =>  Center(child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40),
                color: Colors.white,
                child: Center(
                  child: Text(
                      state.errorResponse!= null ? state.errorResponse!.message : "Undefined Error"),
                ))));
          }
        }

      },
      listenWhen: (state1, state2) {
        return state1.loading != state2.loading ;
      },
      builder: (context, state) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onChanged: (text) {
              BlocProvider.of<AuthenticationBloc>(context).add(UsernameChanged(text));
            },
            style: UtilsTextStyle.primaryTextStyle(color: Colors.black,size: 14),
            decoration: InputDecoration(
                hintText: "Số điện thoại",
                hintStyle: UtilsTextStyle.primaryTextStyle(color: UtilsColor.colorLightGrey,size: 14),
                fillColor: UtilsColor.colorLightGrey,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(style: BorderStyle.none,width: 0),

                )),
          ),
          const SizedBox(height: 24),
          TextFormField(

            obscureText: !state.showPassword,
              onChanged: (text) {
                BlocProvider.of<AuthenticationBloc>(context).add(PasswordChanged(text));
              },
            style: UtilsTextStyle.primaryTextStyle(color: Colors.black,size: 14),
            decoration: InputDecoration(
                isDense: true,
                hintText: "Mật khẩu",
                hintStyle: UtilsTextStyle.primaryTextStyle(color: UtilsColor.colorLightGrey,size: 14),
                fillColor: UtilsColor.colorLightGrey,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),

                suffixIcon: IconButton(
                  icon: Icon(!state.showPassword
                      ? Icons.remove_red_eye_sharp
                      : Icons.remove_red_eye_outlined),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(ShowPassword(!state.showPassword));
                  },
                ),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(style: BorderStyle.none,width: 0),
                    borderRadius: BorderRadius.circular(30)
                )),
          ),
          const SizedBox(height: 18),
    Theme(
    data: Theme.of(context).copyWith(
    checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
      side: BorderSide(width: 1,color:!state.rememberPassword
          ? UtilsColor.colorLightGreen
          : Theme.of(context).disabledColor )
    ),
    ),
              child:CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                activeColor: UtilsColor.colorGreenPrimary,
                checkColor: UtilsColor.colorLightGrey,

                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: UtilsColor.colorLightGrey,width: 1)
                ),
                visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  title: Text(
          "Nhớ mật khẩu",
            style: UtilsTextStyle.primaryTextStyle(color: UtilsColor.colorGrey,size: 14),
          ),
                  value: state.rememberPassword,
                  onChanged: (onChanged) {
                    if (onChanged != null) {
                      BlocProvider.of<AuthenticationBloc>(context).add(RememberPassword(!state.rememberPassword));
                    }
                  })),
          SizedBox(height: 60),
          TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                backgroundColor: TextButton.styleFrom(
                        backgroundColor: UtilsColor.colorGreenPrimary)
                    .backgroundColor),
            onPressed: state.username.isNotEmpty && state.password.isNotEmpty
                ? () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoginButtonPressed());
                  }
                : null,
            child: Center(
              child: Text(
                "Đăng nhập",
                textAlign: TextAlign.center,
                style: UtilsTextStyle.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showDialogLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible:false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
  }

  void showDialogSucces(BuildContext context) {

    showDialog(context: context,builder: (context) =>  Center(child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40),
        color: Colors.white,
        child: const Text("success",textAlign: TextAlign.center,))));
  }
}
