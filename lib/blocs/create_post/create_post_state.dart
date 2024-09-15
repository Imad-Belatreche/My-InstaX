part of 'create_post_bloc.dart';

sealed class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object> get props => [];
}

final class CreatePostInitial extends CreatePostState {}

final class CreatePostFailure extends CreatePostState {}

final class CreatePostLoading extends CreatePostState {}

final class CreatePostSuccess extends CreatePostState {
  final MyPostModel post;

  const CreatePostSuccess({required this.post});
}
// TODO: Here you stopped last time
