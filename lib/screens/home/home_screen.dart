import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instax/blocs/sign_in/sign_in_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('Welcome Imad'),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(const SignOutRequired());
            },
            icon: Icon(CupertinoIcons.square_arrow_right,
                color: Theme.of(context).colorScheme.onSecondary),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.deepPurple,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Imad',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text('2 hours ago'),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer efficitur eros dolor, ut imperdiet dolor varius eu. Etiam tincidunt id dolor quis pretium. Cras hendrerit viverra nisl eu varius. Aliquam at gravida dui. Ut ac enim bibendum, varius risus eget, elementum augue. Nulla ut mi at neque imperdiet elementum. Aenean rhoncus a ex ac dignissim. Phasellus hendrerit eros sem, non porttitor justo luctus nec. Nullam facilisis nisl gravida dui molestie ultricies. Duis eget neque ligula. Vestibulum ut erat vitae magna pretium dictum. Morbi quis vulputate ligula, quis sagittis nulla. Nunc nec sagittis risus. Pellentesque eu augue non magna efficitur lacinia. ')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
