part of 'user_get_bloc.dart';

abstract class UserGetEvent extends Equatable {
  const UserGetEvent();

  @override
  List<Object> get props => [];
}

class GetUserListEvent extends UserGetEvent {}
