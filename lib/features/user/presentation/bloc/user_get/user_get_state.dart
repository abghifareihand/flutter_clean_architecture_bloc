part of 'user_get_bloc.dart';

abstract class UserGetState extends Equatable {
  const UserGetState();

  @override
  List<Object> get props => [];
}

final class UserGetInitial extends UserGetState {}

final class UserGetLoading extends UserGetState {}

final class UserGetLoaded extends UserGetState {
  final List<User> users;

  const UserGetLoaded(this.users);

  @override
  List<Object> get props => [users];
}

final class UserGetError extends UserGetState {
  final String message;

  const UserGetError(this.message);

  @override
  List<Object> get props => [message];
}
