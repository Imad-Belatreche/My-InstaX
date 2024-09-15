part of 'get_post_bloc.dart';

sealed class GetPostEvent extends Equatable {
  const GetPostEvent();

  @override
  List<Object> get props => [];
}

final class GetPost extends GetPostEvent {
  MyPostModel post;
  GetPost(this.post);
}
