import 'package:authentication/bloc/account_list_bloc.dart';
import 'package:authentication/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Quản lý khách hàng",
          style: UtilsTextStyle.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w600,size: 20),
          ),
          leading: IconButton(icon: Icon(Icons.menu), onPressed: () {

          },
          ),
          trailing: Text("11/11/2022",
            style: UtilsTextStyle.primaryTextStyle(color: Colors.white,fontWeight: FontWeight.w600,size: 16,
                family:"Roboto"),
          ),
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) => AccountListBloc(),
      child: AccountListWidget(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {

      },
        child: Icon(Icons.add),
      ),
    );

  }

}

class AccountListWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountListBloc,AccountListState>(
        builder: (context,state) =>
        Container(

        ),
        listener: (context,state){

        });
  }

}

class AccountStatus extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
      Stack(
        children: [
          Image.asset("icon_status_active"

          ),
          Text(
            ""
          )
        ],
      )
      
      
      ,
      
    );
  }

}