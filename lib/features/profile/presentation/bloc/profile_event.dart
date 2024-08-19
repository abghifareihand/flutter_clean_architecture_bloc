part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {}

class ProfileGetAllUser extends ProfileEvent {
  final int page;
  ProfileGetAllUser(this.page);

  @override
  List<Object> get props => [page];
}

class ProfileGetDetailUser extends ProfileEvent {
  final int userId;
  ProfileGetDetailUser(this.userId);

  @override
  List<Object> get props => [userId];
}
