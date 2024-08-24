import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instax/blocs/auth/auth_bloc.dart';
import 'package:my_instax/blocs/sign_in/sign_in_bloc.dart';
import 'package:my_instax/blocs/sign_up/sign_up_bloc.dart';
import 'package:my_instax/screens/auth/sign_in_screen.dart';
import 'package:my_instax/screens/auth/sign_up_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const Text(
                    'Welcome to InstaX',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: kToolbarHeight,
                  ),
                  TabBar(
                    unselectedLabelColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                    labelColor: Theme.of(context).colorScheme.onSurface,
                    controller: tabController,
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        BlocProvider<SignInBloc>(
                          create: (context) => SignInBloc(
                              context.read<AuthBloc>().userRepository),
                          child: const SignInScreen(),
                        ),
                        BlocProvider<SignUpBloc>(
                          create: (context) => SignUpBloc(
                              userRepository:
                                  context.read<AuthBloc>().userRepository),
                          child: const SignUpScreen(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
