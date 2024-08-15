import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  late final StreamSubscription<User?> _userSubscription;

  @override
  Future<void> close() {
    // TODO: implement close
    _userSubscription.cancel();
    return super.close();
  }

  AuthBloc({required UserRepository myUserRepository})
      : userRepository = myUserRepository,
        super(const AuthState.unknown()) {
    _userSubscription = userRepository.user.listen(
      (user) {
        add(AuthUserChanged(user: user));
      },
    );
    on<AuthUserChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthState.authenticated(event.user!));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }
}
