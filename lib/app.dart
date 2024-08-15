import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instax/app_view.dart';
import 'package:my_instax/blocs/auth/auth_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp({
    super.key,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthBloc(myUserRepository: userRepository),
        ),
      ],
      child: const MyAppView(),
    );
  }
}
