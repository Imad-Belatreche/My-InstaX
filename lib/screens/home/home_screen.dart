import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_instax/blocs/sign_in/sign_in_bloc.dart';
import 'package:my_instax/blocs/update_user_info/update_user_info_bloc.dart';
import 'package:my_instax/blocs/user/user_bloc.dart';
import 'package:my_instax/screens/home/post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          setState(() {
            context.read<UserBloc>().state.user!.picture = state.userImage;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostScreen(
                      myUser: state.user!,
                    ),
                  ),
                );
              },
              shape: const CircleBorder(),
              foregroundColor: Theme.of(context).colorScheme.surface,
              child: const Icon(CupertinoIcons.add),
            );
          },
        ),
        appBar: AppBar(
          elevation: 0,
          title: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.status == UserStatus.success) {
                return Row(
                  children: [
                    state.user!.picture == ""
                        ? GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery,
                                maxHeight: 500,
                                maxWidth: 500,
                                imageQuality: 40,
                              );
                              if (image != null) {
                                CroppedFile? croppedFile =
                                    await ImageCropper().cropImage(
                                  sourcePath: image.path,
                                  aspectRatio: const CropAspectRatio(
                                    ratioX: 1,
                                    ratioY: 1,
                                  ),
                                  uiSettings: [
                                    AndroidUiSettings(
                                      toolbarTitle: 'Cropper',
                                      toolbarColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      toolbarWidgetColor: Colors.white,
                                      initAspectRatio:
                                          CropAspectRatioPreset.original,
                                      lockAspectRatio: false,
                                    ),
                                    IOSUiSettings(
                                      title: 'Cropper',
                                    )
                                  ],
                                );
                                if (croppedFile != null) {
                                  setState(() {
                                    context.read<UpdateUserInfoBloc>().add(
                                          UploadPictureEvent(
                                            file: croppedFile.path,
                                            userId: context
                                                .read<UserBloc>()
                                                .state
                                                .user!
                                                .id,
                                          ),
                                        );
                                  });
                                }
                              }
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(CupertinoIcons.person),
                            ),
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(state.user!.picture!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Welcome ${state.user!.name}'),
                  ],
                );
              } else {
                return Container();
              }
            },
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
      ),
    );
  }
}
