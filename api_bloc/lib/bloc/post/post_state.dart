import 'package:api_bloc/model/posts_model.dart';
import 'package:api_bloc/util/api_status.dart';
import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  ApiStatus status;
  List<PostsModel> posts;
  String message;
  PostState({
    this.status = ApiStatus.loading,
    this.posts = const [],
    this.message = '',
  });
  PostState copyWith({
    ApiStatus? status,
    List<PostsModel>? posts,
    String? message,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, posts, message];
}
