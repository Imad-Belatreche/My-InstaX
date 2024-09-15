import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';

part 'get_post_event.dart';
part 'get_post_state.dart';

class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  PostRepository _postRepository;

  GetPostBloc(PostRepository postRepository)
      : _postRepository = postRepository,
        super(GetPostInitial()) {
    on<GetPost>((event, emit) {
      emit(GetPostLoading());
      try {
        emit(GetPostSuccess(posts: posts));
      } catch (e) {
        emit(GetPostFailure());
      }
    });
  }
}
