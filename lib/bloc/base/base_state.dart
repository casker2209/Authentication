import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable{
  BaseState copyWith();

  @override
  List get props => [];
}
