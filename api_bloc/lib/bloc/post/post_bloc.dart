import 'package:api_bloc/bloc/post/post_event.dart';
import 'package:api_bloc/bloc/post/post_state.dart';
import 'package:api_bloc/repository/posts_repository.dart';
import 'package:api_bloc/util/api_status.dart';
import 'package:bloc/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostsRepository repository = PostsRepository();

  PostBloc() : super(PostState()) {
    on<FetchPosts>(_fetchPost);
    on<SearchPostByEmail>(_searchPost);
  }
  void _fetchPost(FetchPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: ApiStatus.loading));
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

  void _searchPost(SearchPostByEmail event, Emitter<PostState> emit) async {
    final query = event.inputValue.trim().toLowerCase();

    if (query.isEmpty) {
      emit(
        state.copyWith(
          status: ApiStatus.success,
          tempPosts: [],
          searchMessage: '',
        ),
      );
      return;
    }

    final posts = state.posts.where((post) {
      final email = post.email?.toLowerCase() ?? "";
      final name = post.name?.toLowerCase() ?? "";
      return email.contains(query) || name.contains(query);
    }).toList();

    emit(
      state.copyWith(
        status: ApiStatus.success,
        tempPosts: posts,
        searchMessage: posts.isEmpty ? "No posts found for '$query'" : '',
      ),
    );
  }
}
