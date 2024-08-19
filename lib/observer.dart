import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

// Memantau perpindahan state
class MyObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('State : $bloc --> $change');
  }
}
