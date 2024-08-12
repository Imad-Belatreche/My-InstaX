import 'dart:developer' show log;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UserState.loading()) {
    on<GetMyUser>((event, emit) async {
      // TODO: implement event handler
      try {
        MyUserModel myUser = await _userRepository.getMyUser(event.myUserId);
        emit(UserState.success(user: myUser));
      } catch (e) {
        log(e.toString());
        emit(const UserState.failure());
        rethrow;
      }
    });
  }
}
