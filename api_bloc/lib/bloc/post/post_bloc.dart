import 'package:api_bloc/bloc/post/post_event.dart';
import 'package:api_bloc/bloc/post/post_state.dart';
import 'package:api_bloc/repository/posts_repository.dart';
import 'package:api_bloc/util/api_status.dart';
import 'package:bloc/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostsRepository repository = PostsRepository();

  PostBloc() : super(PostState()) {
    on<FetchPosts>(_fetchPost);
  }
  void _fetchPost(FetchPosts event, Emitter<PostState> emit) async {
    await repository
        .fetchPosts()
        .then((value) {
          emit(state.copyWith(status: ApiStatus.success, posts: value));
        })
        .onError((error, stackTrace) {
          emit(
            state.copyWith(status: ApiStatus.error, message: error.toString()),
          );
        });
  }
}
