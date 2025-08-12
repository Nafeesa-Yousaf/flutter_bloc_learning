import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class FetchPosts extends PostEvent {}

class SearchPostByEmail extends PostEvent {
  String inputValue;
  SearchPostByEmail({required this.inputValue});
}
