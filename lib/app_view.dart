import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instax/blocs/auth/auth_bloc.dart';
import 'package:my_instax/blocs/sign_in/sign_in_bloc.dart';
import 'package:my_instax/screens/home/home_screen.dart';
import 'package:my_instax/screens/auth/welcome_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InstaX',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromRGBO(206, 147, 216, 1),
          onPrimary: Colors.black,
          secondary: Color.fromRGBO(244, 143, 177, 1),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
          outline: Color(0xFF424242),
        ),
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            return BlocProvider(
              create: (context) => SignInBloc(
                context.read<AuthBloc>().userRepository,
              ),
              child: const HomeScreen(),
            );
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
