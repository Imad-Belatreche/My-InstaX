import 'dart:developer' show log;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

class PostScreen extends StatefulWidget {
  final MyUserModel myUser;
  const PostScreen({super.key, required this.myUser});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late MyPostModel post;
  @override
  void initState() {
    post = MyPostModel.empty;
    //TODO: Here you stopped last time
    post.myUser = widget.myUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(post.toString());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          foregroundColor: Theme.of(context).colorScheme.surface,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(CupertinoIcons.add),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Create a Post'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 10,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: 'What\'s going on in your mind? ',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
