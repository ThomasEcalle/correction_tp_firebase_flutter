import 'dart:async';

import 'package:correction_tp_firebase_flutter/posts/models/post.dart';
import 'package:correction_tp_firebase_flutter/posts/repository/posts_data_source/posts_data_source.dart';

class ErrorPostsDataSource extends PostsDataSource {
  @override
  Future<void> addPost(Post post) {
    throw UnimplementedError();
  }

  @override
  Future<void> editPost(Post newPost) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Post>> getAllPosts() {
    throw UnimplementedError();
  }
}
