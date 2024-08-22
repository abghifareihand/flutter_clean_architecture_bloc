part of 'user_delete_bloc.dart';

abstract class UserDeleteEvent extends Equatable {
  const UserDeleteEvent();

  @override
  List<Object> get props => [];
}

class DeleteUserEvent extends UserDeleteEvent {
  final String id;

  const DeleteUserEvent(this.id);

  @override
  List<Object> get props => [id];
}
