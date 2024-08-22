import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/user/domain/usecases/get_user_detail.dart';

import '../../../domain/entities/user.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final GetUserDetail getUserDetail;
  UserDetailBloc({required this.getUserDetail}) : super(UserDetailInitial()) {
    on<GetUserDetailEvent>((event, emit) async {
      emit(UserDetailLoading());
      final result = await getUserDetail.execute(event.id);
      result.fold(
        (error) => emit(UserDetailError(error.message)),
        (data) => emit(UserDetailLoaded(data)),
      );
    });
  }
}
