import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instax/blocs/sign_in/sign_in_bloc.dart';
import 'package:my_instax/constents/reg_exps.dart';
import 'package:my_instax/screens/auth/widgets/my_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorMsg;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signInRequired = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          setState(() {
            signInRequired = false;
          });
        } else if (state is SignInProccess) {
          signInRequired = true;
        } else if (state is SignInFailure) {
          setState(() {
            signInRequired = false;
            _errorMsg = 'Invalid email or password';
          });
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyFormTextField(
                controller: emailController,
                label: 'Email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: CupertinoIcons.mail_solid,
                errorMsg: _errorMsg,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in all fields';
                  } else if (!emailRegExp.hasMatch(val)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyFormTextField(
                controller: passwordController,
                label: 'Password',
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: CupertinoIcons.lock_fill,
                errorMsg: _errorMsg,
                sufixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                      if (obscurePassword) {
                        iconPassword = CupertinoIcons.eye_fill;
                      } else {
                        iconPassword = CupertinoIcons.eye_slash_fill;
                      }
                    });
                  },
                  icon: Icon(iconPassword),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in all fields';
                  } else if (!passwordRexExp.hasMatch(val)) {
                    return 'Please enter valid input';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            !signInRequired
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SignInBloc>().add(
                                SignInRequired(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                      style: TextButton.styleFrom(
                        elevation: 3,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 5,
                        ),
                        child: Text(
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                : const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
