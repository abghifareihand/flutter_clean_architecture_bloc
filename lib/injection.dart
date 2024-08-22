import 'package:flutter_clean_architecture_bloc/features/user/domain/usecases/get_user_detail.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'features/profile/data/datasources/profile_local_datasource.dart';
import 'features/profile/data/datasources/profile_remote_datasource.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/get_all_user.dart';
import 'features/profile/domain/usecases/get_user.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/user/data/datasources/user_local_datasource.dart';
import 'features/user/data/datasources/user_remote_datasource.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/add_user.dart';
import 'features/user/domain/usecases/delete_user.dart';
import 'features/user/domain/usecases/edit_user.dart';
import 'features/user/domain/usecases/get_user_list.dart';
import 'features/user/presentation/bloc/user_add/user_add_bloc.dart';
import 'features/user/presentation/bloc/user_delete/user_delete_bloc.dart';
import 'features/user/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'features/user/presentation/bloc/user_edit/user_edit_bloc.dart';
import 'features/user/presentation/bloc/user_get/user_get_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // GENERAL
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => Connectivity());

  // SharedPreferences setup
  final pref = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => pref);

  // NETWORK
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: getIt()),
  );

  /// [FEATURE - USER]

  // BLOC
  getIt.registerFactory(
    () => UserGetBloc(
      getUserList: getIt(),
    ),
  );
  getIt.registerFactory(
    () => UserDetailBloc(
      getUserDetail: getIt(),
    ),
  );
  getIt.registerFactory(
    () => UserEditBloc(
      editUser: getIt(),
    ),
  );
  getIt.registerFactory(
    () => UserAddBloc(
      addUser: getIt(),
    ),
  );
  getIt.registerFactory(
    () => UserDeleteBloc(
      deleteUser: getIt(),
    ),
  );

  // USECASE
  getIt.registerLazySingleton(
    () => GetUserList(getIt()),
  );
  getIt.registerLazySingleton(
    () => GetUserDetail(getIt()),
  );
  getIt.registerLazySingleton(
    () => EditUser(getIt()),
  );
  getIt.registerLazySingleton(
    () => AddUser(getIt()),
  );
  getIt.registerLazySingleton(
    () => DeleteUser(getIt()),
  );

  // REPOSITORY
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      userRemoteDatasource: getIt(),
      userLocalDatasource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // DATASOURCE
  getIt.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasourceImpl(client: getIt()),
  );
  getIt.registerLazySingleton<UserLocalDatasource>(
    () => UserLocalDatasourceImpl(prefs: getIt()),
  );

  /// [FEATURE - PROFILE]

  // BLOC
  getIt.registerFactory(
    () => ProfileBloc(
      getAllUser: getIt(),
      getUser: getIt(),
    ),
  );

  // USECASE
  getIt.registerLazySingleton(
    () => GetAllUser(getIt()),
  );
  getIt.registerLazySingleton(
    () => GetUser(getIt()),
  );

  // REPOSITORY
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      profileRemoteDatasource: getIt(),
      profileLocalDatasource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // DATASOURCE
  getIt.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImpl(client: getIt()),
  );

  getIt.registerLazySingleton<ProfileLocalDatasource>(
    () => ProfileLocalDatasourceImpl(prefs: getIt()),
  );
}
