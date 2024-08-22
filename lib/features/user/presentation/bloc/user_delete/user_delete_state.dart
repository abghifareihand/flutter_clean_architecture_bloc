part of 'user_delete_bloc.dart';

abstract class UserDeleteState extends Equatable {
  const UserDeleteState();

  @override
  List<Object> get props => [];
}

final class UserDeleteInitial extends UserDeleteState {}

final class UserDeleteLoading extends UserDeleteState {}

final class UserDeleteLoaded extends UserDeleteState {
  final User user;

  const UserDeleteLoaded(this.user);

  @override
  List<Object> get props => [user];
}

final class UserDeleteError extends UserDeleteState {
  final String message;

  const UserDeleteError(this.message);

  @override
  List<Object> get props => [message];
}
