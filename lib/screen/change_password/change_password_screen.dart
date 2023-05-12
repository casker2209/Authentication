import 'package:authentication/bloc/change_password/change_password_bloc.dart';
import 'package:authentication/bloc/change_password/change_password_event.dart';
import 'package:authentication/bloc/change_password/change_password_state.dart';
import 'package:authentication/screen/base_bloc_network_widget.dart';
import 'package:authentication/utils/color.dart';
import 'package:authentication/utils/dialog_utils.dart';
import 'package:authentication/utils/refreshable_widget.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:authentication/widget/bloc_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends RefreshWidget{
  @override
  Widget build(BuildContext context) {
    return _ChangePasswordBlocConsumer();
    return Scaffold(
      appBar:AppBar(
        title: Text("Đổi mật khẩu",style: UtilsTextStyle.primaryTextStyle(color: Colors.white,size: 20),),
        leadingWidth: 24,
        leading: Padding(
          padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
          child: IconButton(
              icon: Icon(Icons.arrow_back,size: 24),
              onPressed: () {
                context.pop();
              }),
        ),
      ),
      body: _ChangePasswordBlocConsumer(),
    );
  }


  Widget _ChangePasswordBlocConsumer() {
    return BlocProvider<ChangePasswordBloc>(create:(context) => ChangePasswordBloc() ,

      child:BlocConsumer<ChangePasswordBloc,ChangePasswordState>(
        listener: (context,state){
          NetworkHelper.networkListener(context, state,onSuccess:(){
            DialogUtils.showDialogSuccess(context,"Đổi mật khẩu thành công");
          });
        },
        listenWhen: (state1,state2) => state1.loading != state2.loading,
        builder:(context,state) => _ChangePasswordForm(context)
      )
    );
  }



}

class _ChangePasswordForm extends StatefulWidget{
  BuildContext blocContext;
  late ChangePasswordBloc bloc;
  late ChangePasswordState state;
  _ChangePasswordForm(this.blocContext){
    bloc = BlocProvider.of<ChangePasswordBloc>(blocContext);
    state = bloc.state;
  }
  @override
  State<StatefulWidget> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<_ChangePasswordForm>{
late TextEditingController oldPasswordController;
late TextEditingController newPasswordController;
late TextEditingController confirmedPasswordController;

  @override
  void initState() {
    super.initState();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmedPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mật khẩu cũ",
                        style: UtilsTextStyle.primaryTextStyle(
                            height:24/14,
                            color: Colors.black, family: "Roboto", size: 14)),
                    SizedBox(height: 24),
                    Text("Mật khẩu mới",
                        style: UtilsTextStyle.primaryTextStyle(
                            height:24/14,
                            color: Colors.black, family: "Roboto", size: 14)),
                    SizedBox(height:24),
                    Text("Xác nhận mật khẩu",
                        style: UtilsTextStyle.primaryTextStyle(
                            height:24/14,
                            color: Colors.black, family: "Roboto", size: 14)),
                ]),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocTextField(textEditingController: oldPasswordController,hintText:"Mật khẩu cũ"),
                        BlocTextField(textEditingController: newPasswordController,hintText: "Mật khẩu mới"),
                        BlocTextField(textEditingController: confirmedPasswordController,hintText:"Xác nhận mật khẩu")
                      ],
                    ),
                  )
              ],
            ),
          ),
          SizedBox(height: 30),
          InkWell(
              onTap: canClick ? (){
                if(newPasswordController.text != confirmedPasswordController.text) DialogUtils.showDialogError(context, "Mật khẩu xác nhận không trùng mật khẩu mới");
                else {
                  BlocProvider.of<ChangePasswordBloc>(widget.blocContext).add(ButtonPressedEvent(newPassword: newPasswordController.text, oldPassword: oldPasswordController.text));
                }
              } : null,
              child: Container(
          padding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: canClick
              ? UtilsColor.colorGreenPrimary
              : UtilsColor.colorLightGrey,
        ),
        child: Text("Lưu",
          textAlign: TextAlign.center,
          style: UtilsTextStyle.robotoTextStyle(
              color: canClick
                  ? Colors.white
                  : UtilsColor.colorGreenPrimary,
              size: 16))))
        ],
      ),
    );

  }

  bool get canClick{
    return oldPasswordController.text.isNotEmpty && newPasswordController.text.isNotEmpty && confirmedPasswordController.text.isNotEmpty;
  }
}

