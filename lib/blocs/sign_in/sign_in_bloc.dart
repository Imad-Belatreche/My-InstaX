import 'dart:developer' show log;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProccess());
      try {
        final email = event.email;
        final password = event.password;
        await _userRepository.signIn(
          email,
          password,
        );
        emit(SignInSuccess());
      } catch (e) {
        log(e.toString());
        emit(SignInFailure(error: e.toString()));
        rethrow;
      }
    });
    on<SignOutRequired>(
      (event, emit) async {
        try {
          await _userRepository.signOut();
        } catch (e) {
          log(e.toString());
          rethrow;
        }
      },
    );
  }
}
