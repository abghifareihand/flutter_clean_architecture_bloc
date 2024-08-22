part of 'user_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class GetUserDetailEvent extends UserDetailEvent {
  final String id;

  const GetUserDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
