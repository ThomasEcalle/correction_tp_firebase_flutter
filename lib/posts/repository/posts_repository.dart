import 'package:correction_tp_firebase_flutter/posts/repository/posts_data_source/posts_data_source.dart';

import '../models/post.dart';

class PostsRepository {
  PostsDataSource postsDataSource;

  PostsRepository({required this.postsDataSource});

  Stream<List<Post>> getAllPosts() {
    return postsDataSource.getAllPosts();
  }

  Future<void> addPost(Post post) async {
    await postsDataSource.addPost(post);
  }

  Future<void> editPost(Post newPost) async {
    await postsDataSource.editPost(newPost);
  }
}
