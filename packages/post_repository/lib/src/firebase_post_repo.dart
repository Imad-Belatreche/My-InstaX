import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:post_repository/src/entities/entities.dart';
import 'package:post_repository/src/models/my_post_model.dart';
import 'package:post_repository/src/post_repo.dart';
import 'package:uuid/uuid.dart';

class FirebasePostRepository implements PostRepository {
  final postCollection = FirebaseFirestore.instance.collection('posts');

  @override
  Future<MyPostModel> createPost(MyPostModel post) async {
    try {
      post.postId = const Uuid().v1();
      post.createdAt = DateTime.now();

      await postCollection.doc(post.postId).set(post.toEntity().toDocument());
      return post;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<MyPostModel>> getPost() {
    try {
      return postCollection.get().then(
            (value) => value.docs
                .map(
                  (post) => MyPostModel.fromEntity(MyPostEntite.fromDocument(
                    post.data(),
                  )),
                )
                .toList(),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
