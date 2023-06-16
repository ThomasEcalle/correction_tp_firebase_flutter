import '../../models/post.dart';

abstract class PostsDataSource {
  Stream<List<Post>> getAllPosts();

  Future<void> addPost(Post post);

  Future<void> editPost(Post newPost);
}
