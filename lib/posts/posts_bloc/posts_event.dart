part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class GetAllPosts extends PostsEvent {}

class AddPost extends PostsEvent {
  final Post post;

  AddPost({required this.post});
}

class UpdatePost extends PostsEvent {
  final Post post;

  UpdatePost({required this.post});
}
