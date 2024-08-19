import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/profile.dart';
import '../../domain/usecases/get_all_user.dart';
import '../../domain/usecases/get_user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetAllUser getAllUser;
  final GetUser getUser;

  ProfileBloc({required this.getAllUser, required this.getUser}) : super(ProfileInitial()) {
    on<ProfileGetAllUser>((event, emit) async {
      emit(ProfileLoading());
      final result = await getAllUser.execute(event.page);
      result.fold(
        (error) => emit(ProfileError(error.message)),
        (data) => emit(ProfileLoadedAllUser(data)),
      );
    });

    on<ProfileGetDetailUser>((event, emit) async {
      emit(ProfileLoading());
      final result = await getUser.execute(event.userId);
      result.fold(
        (error) => emit(ProfileError(error.message)),
        (data) => emit(ProfileLoadedUser(data)),
      );
    });
  }
}
