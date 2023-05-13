import 'package:authentication/bloc/authentication/authentication_event.dart';
import 'package:authentication/bloc/authentication/authentication_state.dart';
import 'package:authentication/screen/base_bloc_network_widget.dart';
import 'package:authentication/utils/go_router.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../utils/color_utils.dart';

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
      body: BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc()..add(GetPasswordEvent()),
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
                    style: TextStyleUtils.primaryTextStyle(
                        color: ColorUtils.colorGreenPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 85),
                Text(
                  "Xin Chào",
                  textAlign: TextAlign.start,
                  style: TextStyleUtils.primaryTextStyle(
                    color: ColorUtils.colorGreenPrimary,
                    size: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Đăng nhập để tiếp tục",
                  textAlign: TextAlign.start,
                  style: TextStyleUtils.primaryTextStyle(
                    color: ColorUtils.colorGreenPrimary,
                    fontWeight: FontWeight.w500,
                    size: 19,
                  ),
                ),
                const SizedBox(height: 30),
                _AuthenticationForm()
              ],
            ),
          ),
      ),
    );
  }
}

class _AuthenticationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc,AuthenticationState>(builder:
    (context,state) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (text) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(UsernameChanged(text));
          },
          keyboardType:TextInputType.phone,
          style:
          TextStyleUtils.primaryTextStyle(color: Colors.black, size: 14),
          decoration: InputDecoration(
              hintText: "Số điện thoại",
              hintStyle: TextStyleUtils.primaryTextStyle(
                  color: ColorUtils.colorGrey, size: 14),
              fillColor: ColorUtils.colorLightGrey,
              filled: true,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                const BorderSide(style: BorderStyle.none, width: 0),
              )
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          obscureText: !state.showPassword,
          onChanged: (text) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(PasswordChanged(text));
          },
          style:
          TextStyleUtils.primaryTextStyle(color: Colors.black, size: 14),
          decoration: InputDecoration(
              isDense: true,
              hintText: "Mật khẩu",
              hintStyle: TextStyleUtils.primaryTextStyle(
                  color: ColorUtils.colorGrey, size: 14),
              fillColor: ColorUtils.colorLightGrey,
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
                  borderSide:
                  const BorderSide(style: BorderStyle.none, width: 0),
                  borderRadius: BorderRadius.circular(30))),
        ),
        const SizedBox(height: 18),
        Theme(
            data: Theme.of(context).copyWith(
              checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
                  side: BorderSide(
                      width: 1,
                      color: !state.rememberPassword
                          ? ColorUtils.colorLightGreen
                          : Theme.of(context).disabledColor)),
            ),
            child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                activeColor: ColorUtils.colorGreenPrimary,
                checkColor: ColorUtils.colorLightGrey,
                checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                        color: ColorUtils.colorLightGrey, width: 1)),
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Nhớ mật khẩu",
                  style: TextStyleUtils.primaryTextStyle(
                      color: ColorUtils.colorGrey, size: 14),
                ),
                value: state.rememberPassword,
                onChanged: (onChanged) {
                  if (onChanged != null) {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(RememberPassword(!state.rememberPassword));
                  }
                })),
        const SizedBox(height: 60),
        TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
              backgroundColor: TextButton.styleFrom(
                  backgroundColor: state.canLogin ? ColorUtils.colorGreenPrimary : ColorUtils.colorLightGrey)
                  .backgroundColor),
          onPressed: state.canLogin
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
              style: TextStyleUtils.primaryTextStyle(
                  color: state.canLogin ? Colors.white : ColorUtils.colorGreenPrimary, fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    ),
        listener: (context,state){
          NetworkHelper.networkListener(context, state,onSuccess: (){
            _handleDialogSucces(context);
          });
      },
        listenWhen: (state1,state2){
          return state1.loading != state2.loading;
        },
    );
  }

  void _handleDialogSucces(BuildContext context) {
      context.go("/home");
  }
}
