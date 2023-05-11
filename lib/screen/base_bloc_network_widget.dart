import 'package:authentication/bloc/base/base_bloc.dart';
import 'package:authentication/bloc/network/network_bloc.dart';
import 'package:authentication/bloc/network/network_state.dart';
import 'package:authentication/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NetworkBlocListener extends StatelessWidget{
  Function? onSuccess;
  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkBloc,NetworkState>(listener: (context,state){
      NetworkHelper.networkListener(context, state,onSuccess: onSuccess);
    },
      listenWhen: (state1,state2) => state1.loading != state2.loading,

    );
  }

}

class NetworkHelper{
  static void networkListener(context, state, {Function? onSuccess,Function? onError}) {
    if (state is NetworkState) {
      if (state.loading) {
        DialogUtils.showDialogLoading(context);
      }
      else {
        Navigator.of(context).pop();
        if (state.success) {
          if (onSuccess != null) onSuccess.call();
        }
        else {
          //if(onError!=null) onError;
          DialogUtils.showDialogError(context, state.message);
          if(onError != null) onError.call();
        }
      }
    }
  }
  static Widget networkBuilder(context,NetworkState state,{Widget? loadingWidget,Widget? errorWidget,required Widget widget}){
    if(state.loading && loadingWidget!=null) return loadingWidget!;
    if(!state.success && errorWidget!=null) return errorWidget;
    return widget;
  }
}

