import 'package:api_bloc/model/posts_model.dart';
import 'package:api_bloc/util/api_status.dart';
import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  ApiStatus status;
  List<PostsModel> posts;
  String message;
  List<PostsModel> tempPosts;
  String searchMessage;
  PostState({
    this.status = ApiStatus.loading,
    this.posts = const [],
    this.tempPosts = const [],
    this.message = '',
    this.searchMessage = '',
  });
  PostState copyWith({
    ApiStatus? status,
    List<PostsModel>? posts,
    List<PostsModel>? tempPosts,
    String? message,
    String? searchMessage,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      tempPosts: tempPosts ?? this.tempPosts,
      message: message ?? this.message,
      searchMessage: searchMessage ?? this.searchMessage,
    );
  }

  @override
  List<Object?> get props => [status, posts, message, tempPosts, searchMessage];
}
