import 'package:flutter_bloc/flutter_bloc.dart';

class AccountListBloc extends Bloc<AccountListEvent,AccountListState>{
  AccountListBloc():super(AccountListState()){

  }

}

abstract class AccountListEvent {}

class AccountListState{
  List<dynamic> accountList;
  AccountListState({this.accountList = const []});

  AccountListState copyWith({
    List<dynamic>? accountList,
  }) {
    return AccountListState(
      accountList: accountList ?? this.accountList,
    );
  }

}