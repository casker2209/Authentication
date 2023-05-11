import 'dart:math';

import 'package:authentication/bloc/create_user_bloc/create_user_bloc.dart';
import 'package:authentication/bloc/create_user_bloc/create_user_event.dart';
import 'package:authentication/bloc/create_user_bloc/create_user_state.dart';
import 'package:authentication/network/get_user.dart';
import 'package:authentication/screen/base_bloc_network_widget.dart';
import 'package:authentication/utils/color.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:authentication/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:go_router/go_router.dart';

class CreateUserScreen extends StatefulWidget {
  User? user;
  CreateUserScreen({this.user});
  @override
  State<StatefulWidget> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUserScreen> {
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    if(widget.user!=null){
      usernameController.text = widget.user!.username!;
      nameController.text = widget.user!.name!;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("Thêm tài khoản"),
        ),
        leadingWidth: 24,
        leading: Padding(
          padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
          child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              }),
        ),
      ),
      backgroundColor: Colors.white,
      body: _CreateUserBlocConsumer(widget.user));
        }

  BlocProvider _CreateUserBlocConsumer(User? user){
    User? user;
    return BlocProvider<CreateUserBloc>(
        create: (_) => CreateUserBloc(user: user),
        child: BlocConsumer<CreateUserBloc, CreateUserState>(
            builder: (context, state) => CreateUserWidget(
              state,
              usernameController: usernameController,
              name: nameController,
              password: passwordController,
            ),
            listener: (context, state) {
              NetworkHelper.networkListener(context, state, onSuccess: () {
                context.push("/success");
              });
            },
            listenWhen: (state1, state2) {
              return state1.loading != state2.loading;
            }));
  }

}


class CreateUserWidget extends StatelessWidget {
  CreateUserState _state;
  TextEditingController usernameController;
  TextEditingController name;
  TextEditingController password;
  CreateUserWidget(this._state,
      {required this.usernameController, required this.name, required this.password});

  @override
  Widget build(BuildContext context) {
    CreateUserBloc bloc = BlocProvider.of<CreateUserBloc>(context);
    if (!usernameController.hasListeners)
      usernameController.addListener(() {
        bloc.add(CheckConditionEvent(canClick));
      });
    if (!password.hasListeners) {
      password.addListener(() {
        bloc.add(CheckConditionEvent(canClick));
      });
    }
    if (!name.hasListeners)
      name.addListener(() {
        bloc.add(CheckConditionEvent(canClick));
      });
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          usernameForm(bloc),
          const SizedBox(height: 20),
          nameForm(bloc),
          const SizedBox(height: 20),
          passwordForm(bloc),
          const SizedBox(height: 32),
          Center(
            child: TextButton(
              onPressed: () {
                if (canClick) {
                  bloc.add(ButtonPressedEvent(
                      name: name.text,
                      password: password.text,
                      phoneNumber: usernameController.text));
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: canClick
                      ? UtilsColor.colorGreenPrimary
                      : UtilsColor.colorLightGrey,
                ),
                child: Text(
                  "Thêm",
                  textAlign: TextAlign.center,
                  style: UtilsTextStyle.robotoTextStyle(
                      color: canClick
                          ? Colors.white
                          : UtilsColor.colorGreenPrimary,
                      size: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget nameForm(Bloc bloc) {
    return Row(
      children: [
        Text(
          "Họ tên",
          style: UtilsTextStyle.primaryTextStyle(
              color: Colors.black, family: "Roboto", size: 14),
        ),
        Spacer(),
        SizedBox(
          width: 200,
          child: TextFormField(
            maxLines: 1,
            controller: name,
            decoration: InputDecoration(
                hintText: "Họ tên",
                hintStyle: UtilsTextStyle.primaryTextStyle(
                    color: UtilsColor.colorGrey2, size: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: UtilsColor.colorGreenPrimary, width: 2))),
          ),
        ),
        SizedBox(width: 20),
        InkWell(
          onTap: () {
            bloc.add(GetContactEvent());
          },
          child: Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
                color: UtilsColor.colorGreenPrimary,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text("Danh bạ",
                  style: UtilsTextStyle.primaryTextStyle(
                      color: Colors.white, family: "Roboto", size: 14)),
            ),
          ),
        )
      ],
    );
  }

  Widget usernameForm(Bloc bloc) {
    return Row(
      children: [
        Text("SĐT",
            style: UtilsTextStyle.primaryTextStyle(
                color: Colors.black, family: "Roboto", size: 14)),
        Spacer(),
        SizedBox(
          width: 200,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            maxLines: 1,
            controller: usernameController,
            decoration: InputDecoration(
                hintText: "Số điện thoại",
                hintStyle: UtilsTextStyle.primaryTextStyle(
                    color: UtilsColor.colorGrey2, size: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                        color: UtilsColor.colorGreenPrimary, width: 2))),
          ),
        ),
        const SizedBox(width: 20),
        InkWell(
          onTap: () {
            bloc.add(ClearTextEvent());
          },
          child: Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
                color: UtilsColor.colorGreenPrimary,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text("Đặt lại",
                  style: UtilsTextStyle.primaryTextStyle(
                      color: Colors.white, family: "Roboto", size: 14)),
            ),
          ),
        )
      ],
    );
  }

  Widget passwordForm(Bloc bloc) {
    return Row(
      children: [
        Text("MK",
            style: UtilsTextStyle.primaryTextStyle(
                color: Colors.black, family: "Roboto", size: 14)),
        Spacer(),
        SizedBox(
          width: 200,
          child: TextFormField(
            maxLines: 1,
            controller: password,
            obscureText: _state.showPassword,
            decoration: InputDecoration(
                hintText: "Mật khẩu",
                hintStyle: UtilsTextStyle.primaryTextStyle(
                    color: UtilsColor.colorGrey2, size: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                        color: UtilsColor.colorGreenPrimary, width: 2)),
                suffixIcon: IconButton(
                  icon: Icon(_state.showPassword
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye),
                  onPressed: () {
                    bloc.add(ShowPasswordEvent(!_state.showPassword));
                  },
                )),
          ),
        ),
        const SizedBox(width: 20),
        InkWell(
          onTap: () {
            password.text = Utils.randomString();
          },
          child: Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
                color: UtilsColor.colorGreenPrimary,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text("Mặc định",
                  style: UtilsTextStyle.primaryTextStyle(
                      color: Colors.white, family: "Roboto", size: 14)),
            ),
          ),
        )
      ],
    );
  }

  bool get canClick => usernameController.text.isNotEmpty && name.text.isNotEmpty && (password.text.length >= 15 || _state.user!=null);

  void clearAll(){
    usernameController.clear();
    name.clear();
    password.clear();
  }
}
