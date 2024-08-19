import 'package:flutter_clean_architecture_bloc/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'features/profile/data/datasources/profile_local_datasource.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/get_all_user.dart';
import 'features/profile/domain/usecases/get_user.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // GENERAL
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => Connectivity());

  // SharedPreferences setup
  final pref = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => pref);

  /// FEATURE - PROFILE

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

  // NETWORK
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: getIt()),
  );
}
