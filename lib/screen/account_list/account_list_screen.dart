import 'package:authentication/bloc/account_list/account_list_bloc.dart';
import 'package:authentication/bloc/account_list/account_list_event.dart';
import 'package:authentication/bloc/account_list/account_list_state.dart';
import 'package:authentication/network/get_user.dart';
import 'package:authentication/network/login.dart';
import 'package:authentication/screen/base_bloc_network_widget.dart';
import 'package:authentication/utils/color.dart';
import 'package:authentication/utils/refreshable_widget.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AccountListScreenState();
}

class RefreshAccountListScreen extends RefreshWidget{
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AccountListBloc()..add(GetUserEvent())),
        BlocProvider(create: (_) => UpdateRemoveUserBloc())
      ],
      child: _AccountListWidget(),
    );
  }

  @override
  void refreshCallback() {
    super.refreshCallback();
    AccountListBloc().add(GetUserEvent());
  }

}

class _AccountListScreenState extends State<AccountListScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AccountListBloc().add(GetUserEvent());
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AccountListBloc()..add(GetUserEvent())),
          BlocProvider(create: (_) => UpdateRemoveUserBloc())
        ],
        child: _AccountListWidget(),
      );
  }
}

class _AccountListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountListBloc bloc = BlocProvider.of<AccountListBloc>(context);
    return BlocListener<UpdateRemoveUserBloc, UpdateRemoveState>(
      listener: (contextUpdateRemove, state) {
        NetworkHelper.networkListener(contextUpdateRemove, state, onSuccess: () {
          if (state.index != -1) {
            BlocProvider.of<AccountListBloc>(context).add(UpdateRemoveUserEvent(
                index: state.index, status: state.status));
          }
        });
      },
      listenWhen: (state1, state2) {
        return state1.loading != state2.loading;
      },
      child: BlocConsumer<AccountListBloc, AccountListState>(
        builder: (context, state) => Container(
            decoration: BoxDecoration(color: UtilsColor.colorLightGrey),
            height: double.infinity,
            width: double.infinity,
            child: bloc.state.success && bloc.state.response! is GetUserResponse
                ? SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          List<User> data = state.users;
                          return _AccountStatus(data[index], index: index);
                        },
                        itemCount: state.users.length),
                  )
                : _ErrorScreen(text: bloc.state.message)),
        buildWhen: (state1,state2) => state1!=state2,
        listener: (context, state) {
          NetworkHelper.networkListener(context, state, onSuccess: () {});
        },
        listenWhen: (state1, state2) {
          return state1.loading != state2.loading;
        },
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  String text;
  _ErrorScreen({required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}

class _AccountStatus extends StatelessWidget {
  _AccountStatus(this.user, {required this.index});
  int index;
  User user;

  @override
  Widget build(BuildContext context) {
    String image;
    switch (user.status) {
      case "ACTIVATED":
        image = "assets/images/icon_status_active.png";
        break;
      case "DEACTIVATED":
        image = "assets/images/icon_status_deactive.png";
        break;
      default:
        image = "assets/images/icon_status_sms.png";
        break;
    }
    return GestureDetector(
      onTap: () {
        context.push("/create", extra: user);
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (dialogContext_) {
              return Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: []..addAll([
                      dialogOption(user, dialogContext_, context,
                          status: "ACTIVATED"),
                    Container(width: double.infinity,color: Colors.black,height: 0.1),
                    dialogOption(user, dialogContext_, context,
                          status: "DEACTIVATED"),
                    Container(width: double.infinity,color: Colors.black,height: 0.1),
                    dialogOption(user, dialogContext_, context,
                          status: "SMS"),
                      Container(width: double.infinity,color: Colors.black,height: 0.1),
                      dialogOption(user, dialogContext_, context)
                    ]),
                ),
              );
            });
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(4, 4, 8, 0),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
              width: 43,
              height: 43,
            ),
            SizedBox(width: 16),
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name!,
                      style: UtilsTextStyle.primaryTextStyle(
                          color: Colors.black,
                          size: 18,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 6),
                  Text("Phone: ${user.username}",
                      style: UtilsTextStyle.primaryTextStyle(
                          color: UtilsColor.colorDarkGrey,
                          size: 13,
                          fontWeight: FontWeight.w500))
                ]),
          ],
        ),
      ),
    );
  }

  Widget dialogOption(
      User user, BuildContext _context, BuildContext _blocContext,
      {String? status}) {
    return status == null
        ? InkWell(
            onTap: () {
              Navigator.of(_context).pop();
              BlocProvider.of<UpdateRemoveUserBloc>(_blocContext)
                  .add(DeleteUserEvent(user.username!, index));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
              child: Text("Xóa",
                  style: UtilsTextStyle.robotoTextStyle(color: Colors.black)),
            ),
          )
        : user.status == status
            ? Container()
            : InkWell(
                onTap: () {
                  Navigator.of(_context).pop();
                  BlocProvider.of<UpdateRemoveUserBloc>(_blocContext)
                      .add(UpdateUserEvent(status, user.username!, index));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
                  child: Text(
                    "Đổi trạng thái sang ${status.toLowerCase()}",
                    style: UtilsTextStyle.robotoTextStyle(color: Colors.black),
                  ),
                ),
              );
  }
}
