import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

class MyPostEntite extends Equatable {
  final String postId;
  final String post;
  final DateTime createdAt;
  final MyUserModel myUser;

  const MyPostEntite({
    required this.postId,
    required this.post,
    required this.createdAt,
    required this.myUser,
  });

  Map<String, Object?> toDocument() {
    return {
      'postId': postId,
      'post': post,
      'createdAt': createdAt,
      'myUser': myUser.toEntity().toDocument(),
    };
  }

  static MyPostEntite fromDocument(Map<String, dynamic> doc) {
    return MyPostEntite(
      postId: doc['postId'],
      post: doc['post'],
      createdAt: DateTime.parse(doc['createdAt']),
      myUser: MyUserModel.fromEntity(MyUserEntite.fromDocument(doc['myUser'])),
    );
  }

  @override
  String toString() {
    return '''PostEntity: {
      postId: $postId,
      post: $post,
      createdAt: $createdAt,
      myUser: $myUser,
      }''';
  }

  @override
  List<Object?> get props => [postId, post, createdAt, myUser];
}
