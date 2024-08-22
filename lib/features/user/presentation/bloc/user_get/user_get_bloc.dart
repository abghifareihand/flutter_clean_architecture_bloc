import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_user_list.dart';

part 'user_get_event.dart';
part 'user_get_state.dart';

class UserGetBloc extends Bloc<UserGetEvent, UserGetState> {
  final GetUserList getUserList;
  UserGetBloc({required this.getUserList}) : super(UserGetInitial()) {
    on<GetUserListEvent>((event, emit) async {
      emit(UserGetLoading());
      final result = await getUserList.execute();
      result.fold(
        (error) => emit(UserGetError(error.message)),
        (data) => emit(UserGetLoaded(data)),
      );
    });
  }
}
