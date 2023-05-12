import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/bloc/widget/text_field/text_field_event.dart';
import 'package:authentication/bloc/widget/text_field/text_field_state.dart';

class TextFieldBloc extends Bloc<TextFieldEvent,TextFieldState>{
  TextFieldBloc():super(TextFieldState()){
    on((event,emit){
      if(event is TextFieldEvent){
        emit(state.copyWith(showPassword:event.showPassword));
      }
    });
  }
}