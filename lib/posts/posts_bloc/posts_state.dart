part of 'posts_bloc.dart';

enum PostsStatus {
  initial,
  fetchingPosts,
  addingPost,
  updatingPost,
  fetchedPosts,
  addedPost,
  updatedPost,
  errorFetchingPosts,
  errorAddingPost,
  errorUpdatingPost
}

class PostsState {
  final PostsStatus status;
  final List<Post> posts;

  const PostsState({
    this.status = PostsStatus.initial,
    this.posts = const <Post>[],
  });

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }
}
