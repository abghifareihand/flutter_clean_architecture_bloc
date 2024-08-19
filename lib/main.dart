import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/core/routes/app_route.dart';
import 'package:flutter_clean_architecture_bloc/observer.dart';

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
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: false,
      ),
      routerConfig: AppRouter.router,
    );
  }
}


/// DOMAIN LAYER
/// 1. ENTITIES
/// 2. REPOSITORIES (ABSTRACT)
/// 3. USE CASE


/// DATA LAYER
/// 1. MODEL (EXTEND ENTITIES)
/// 3. REPOSITORIES (IMPLEMENTASION)
/// 2. DATASOURCES


/// PRESENTATION LAYER
/// 1. SLICING UI
/// 2. STATE MANAGEMENT PANGGIL USE CASE