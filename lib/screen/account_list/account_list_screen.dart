import 'package:authentication/bloc/account_list_bloc.dart';
import 'package:authentication/network/get_user.dart';
import 'package:authentication/network/login.dart';
import 'package:authentication/utils/Color.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 23,

        title: Row(
          children: [

            InkWell(child: Icon(Icons.menu,color: Colors.white,size: 16),
              onTap: () {

              },
            ),
            SizedBox(width: 30),
            Text("Quản lý khách hàng",
              style: UtilsTextStyle.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w600,size: 20),
            ),
            Spacer(),
            Text("11/11/2022",
              style: UtilsTextStyle.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w600,size: 16,
                  family:"Roboto"),
            )
          ],
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) => AccountListBloc()..add(GetUserEvent()),
      child: AccountListWidget(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        context.go("/create");
      },
        backgroundColor: UtilsColor.colorGreenPrimary,
        child: Icon(Icons.add),
      ),
    );

  }

}


class AccountListWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AccountListBloc bloc = BlocProvider.of<AccountListBloc>(context);
    return BlocConsumer<AccountListBloc,AccountListState>(
        builder: (context,state) =>
        Container(
          decoration: BoxDecoration(
            color: UtilsColor.colorLightGrey
          ),
          height: double.infinity,
          width: double.infinity,
          child:
          state.loading ? LoadingScreen() : state.success && state.response! is GetUserResponse ? SingleChildScrollView(
            child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context,index) {
                  List<User> data = (BlocProvider.of<AccountListBloc>(context).state.response as GetUserResponse).data!;
                  return AccountStatus(data[index]);
                },
                itemCount: (bloc.state.response as GetUserResponse).total),
          ) : ErrorScreen(text:state.message),
        ),
        listener: (context,state){

        });
  }

}

class LoadingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}

class ErrorScreen extends StatelessWidget{
  String text;
  ErrorScreen({required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }

}

class AccountStatus extends StatelessWidget {
  AccountStatus(this.user);

  User user;

  @override
  Widget build(BuildContext context) {
    String image;
    switch(user.status){
      case "active":
        image = "assets/images/icon_status_active.png";
        break;
      case "deactive":
        image = "assets/images/icon_status_deactive.png";
        break;
      default:
        image = "assets/images/icon_status_sms.png";
        break;
    }
    return Container(
      margin: EdgeInsets.fromLTRB(4,4,8,0),
      padding: EdgeInsets.symmetric(vertical: 14,horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,width: 43,height: 43,
            ),
            SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name!,style:
                UtilsTextStyle.primaryTextStyle(color: Colors.black,size:18,fontWeight:FontWeight.w600)),
                  SizedBox(height:6),
                  Text("Phone: ${user.username}",style:
                  UtilsTextStyle.primaryTextStyle(color: UtilsColor.colorDarkGrey,size:13,fontWeight:FontWeight.w500)
                  )
              ]),
          ],
        ),
    );
  }
}