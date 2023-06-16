import 'dart:async';

import 'package:correction_tp_firebase_flutter/posts/models/post.dart';
import 'package:correction_tp_firebase_flutter/posts/repository/posts_data_source/posts_data_source.dart';

class DummyPostsDataSource extends PostsDataSource {
  final List<Post> _posts = [];
  final StreamController<List<Post>> _postsStreamController = StreamController<List<Post>>.broadcast();

  @override
  Future<void> addPost(Post post) async {
    _posts.add(post);
    _postsStreamController.add(_posts);
  }

  @override
  Stream<List<Post>> getAllPosts() {
    return _postsStreamController.stream;
  }

  @override
  Future<void> editPost(Post newPost) async {
    final index = _posts.indexWhere((post) => post.id == newPost.id);
    _posts[index] = newPost;
    _postsStreamController.add(_posts);
  }
}
