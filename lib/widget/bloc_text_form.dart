import 'package:authentication/bloc/widget/text_field/text_field_bloc.dart';
import 'package:authentication/bloc/widget/text_field/text_field_event.dart';
import 'package:authentication/bloc/widget/text_field/text_field_state.dart';
import 'package:authentication/utils/color.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocTextField extends StatefulWidget{
  TextEditingController textEditingController;
  String hintText;
  double size;
  Color color;
  Color hintColor ;
  Color? fillColor ;
  InputBorder? inputBorder;


  BlocTextField({required this.textEditingController,required this.hintText,this.size = 14,this.color = Colors.black,this.hintColor = UtilsColor.colorGrey,this.fillColor,this.inputBorder});
  @override
  State<StatefulWidget> createState() => _BlocTextFieldState();

}

class _BlocTextFieldState extends State<BlocTextField>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TextFieldBloc>(create: (context) => TextFieldBloc(),
    child: BlocBuilder<TextFieldBloc,TextFieldState>(
      builder: (context,state) {
        return SizedBox(
          child: TextField(
            obscureText: !state.showPassword,
            controller: widget.textEditingController,
            style:
            UtilsTextStyle.primaryTextStyle(color: widget.color, size: widget.size),
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                hintText: "Mật khẩu",
                hintStyle: UtilsTextStyle.primaryTextStyle(
                    color: widget.hintColor, size: 12),
                fillColor: widget.fillColor,

                suffixIcon: IconButton(
                  icon: Icon(!state.showPassword
                      ? Icons.remove_red_eye_sharp
                      : Icons.remove_red_eye_outlined,size: 14,),
                  onPressed: () {
                    BlocProvider.of<TextFieldBloc>(context).add(TextFieldEvent(!state.showPassword));
                  },
                ),
                border: widget.inputBorder ??  OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: UtilsColor.colorGreenPrimary, width: 2))),
          ),
        );
      },
      ),
    );
  }

}