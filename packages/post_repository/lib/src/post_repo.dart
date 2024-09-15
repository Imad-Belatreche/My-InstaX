import 'package:post_repository/src/models/models.dart';

abstract class PostRepository {
  Future<MyPostModel> createPost(MyPostModel post);

  Future<List<MyPostModel>> getPost();
}
