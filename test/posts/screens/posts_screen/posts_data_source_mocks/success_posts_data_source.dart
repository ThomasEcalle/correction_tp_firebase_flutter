import 'dart:async';

import 'package:correction_tp_firebase_flutter/posts/models/post.dart';
import 'package:correction_tp_firebase_flutter/posts/repository/posts_data_source/posts_data_source.dart';

class SuccessPostsDataSource extends PostsDataSource {
  final StreamController<List<Post>> _postStreamController = StreamController<List<Post>>();

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
    _postStreamController.add([
      Post(title: 'Test post 1 title', description: 'Test post 1 description'),
      Post(title: 'Test post 2 title', description: 'Test post 2 description'),
      Post(title: 'Test post 3 title', description: 'Test post 3 description'),
    ]);
    return _postStreamController.stream;
  }
}
