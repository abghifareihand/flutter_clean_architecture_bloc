import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/core/routes/app_route.dart';
import 'package:flutter_clean_architecture_bloc/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_clean_architecture_bloc/observer.dart';

import 'features/user/presentation/bloc/user_add/user_add_bloc.dart';
import 'features/user/presentation/bloc/user_delete/user_delete_bloc.dart';
import 'features/user/presentation/bloc/user_detail/user_detail_bloc.dart';
import 'features/user/presentation/bloc/user_edit/user_edit_bloc.dart';
import 'features/user/presentation/bloc/user_get/user_get_bloc.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Bloc.observer = MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<UserGetBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<UserDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<UserEditBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<UserAddBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<UserDeleteBloc>(),
        ),

        // PROFILE
        BlocProvider(
          create: (context) => getIt<ProfileBloc>(),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          useMaterial3: false,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}


/// DOMAIN LAYER
/// 1. ENTITIES
/// 2. REPOSITORIES (ABSTRACT)
/// 3. USE CASE


/// DATA LAYER
/// 1. MODEL (EXTEND ENTITIES)
/// 2. DATASOURCES (PAKE DARI MODEL)
/// 3. REPOSITORIES (IMPLEMENTASION)


/// PRESENTATION LAYER
/// 1. SLICING UI
/// 2. STATE MANAGEMENT PANGGIL USE CASE