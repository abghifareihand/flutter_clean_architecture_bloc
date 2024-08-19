part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
  @override
  List<Object?> get props => [message];
}

class ProfileLoadedAllUser extends ProfileState {
  final List<Profile> allUser;

  ProfileLoadedAllUser(this.allUser);
  @override
  List<Object?> get props => [allUser];
}

class ProfileLoadedUser extends ProfileState {
  final Profile detailUser;

  ProfileLoadedUser(this.detailUser);
  @override
  List<Object?> get props => [detailUser];
}
