import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

class MyPostModel extends Equatable {
  String postId;
  String post;
  DateTime createdAt;
  MyUserModel myUser;

  MyPostModel({
    required this.postId,
    required this.post,
    required this.createdAt,
    required this.myUser,
  });

  // Empty user which represent unauthenticated user
  static final empty = MyPostModel(
    postId: '',
    post: '',
    createdAt: DateTime.now(),
    myUser: MyUserModel.empty,
  );

  MyPostModel copyWith({
    String? postId,
    String? post,
    DateTime? createdAt,
    MyUserModel? myUser,
  }) {
    return MyPostModel(
      postId: postId ?? this.postId,
      post: post ?? this.post,
      createdAt: createdAt ?? this.createdAt,
      myUser: myUser ?? this.myUser,
    );
  }

  // Getter to verify if the user is empty
  bool get isEmpty => this == MyPostModel.empty;

  // Getter to verify if the user is not empty
  bool get isNotEmpty => this != MyPostModel.empty;

  MyPostEntite toEntity() {
    return MyPostEntite(
      postId: postId,
      post: post,
      createdAt: createdAt,
      myUser: myUser,
    );
  }

  static MyPostModel fromEntity(MyPostEntite entity) {
    return MyPostModel(
      postId: entity.postId,
      post: entity.post,
      createdAt: entity.createdAt,
      myUser: entity.myUser,
    );
  }

  @override
  String toString() {
    return '''PostModel: {
      postId: $postId,
      post: $post,
      createdAt: $createdAt,
      myUser: $myUser,
      }''';
  }

  @override
  List<Object?> get props => [post, postId, myUser, createdAt];
}
