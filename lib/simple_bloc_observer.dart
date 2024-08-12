import 'dart:developer' show log;

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // TODO: implement onEvent
    log('onEvent -- ${bloc.runtimeType} event: $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // TODO: implement onError
    log('onError -- ${bloc.runtimeType} || event: $error || stack trace: $stackTrace');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // TODO: implement onChange
    log('onChange -- ${bloc.runtimeType} || change: $change ');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // TODO: implement onChange
    log('onTransition -- ${bloc.runtimeType} || transition: $transition ');
  }
}
