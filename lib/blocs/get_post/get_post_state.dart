part of 'get_post_bloc.dart';

sealed class GetPostState extends Equatable {
  const GetPostState();

  @override
  List<Object> get props => [];
}

final class GetPostInitial extends GetPostState {}

final class GetPostSuccess extends GetPostEvent {
  final List<MyPostModel> posts;

  const GetPostSuccess({required this.posts});
}

final class GetPostLoading extends GetPostEvent {}

final class GetPostFailure extends GetPostEvent {}
