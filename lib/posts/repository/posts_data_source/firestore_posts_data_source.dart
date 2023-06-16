import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:correction_tp_firebase_flutter/posts/models/post.dart';
import 'package:correction_tp_firebase_flutter/posts/repository/posts_data_source/posts_data_source.dart';

class FirestorePostsDataSource extends PostsDataSource {

  final CollectionReference _postCollection = FirebaseFirestore.instance.collection('posts');

  @override
  Future<void> addPost(Post post) {
    try {
      return _postCollection.add(post.toMap());
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> editPost(Post newPost) {
    try {
      return _postCollection.doc(newPost.id).update(newPost.toMap());
    } catch (error) {
      rethrow;
    }
  }

  @override
  Stream<List<Post>> getAllPosts() {
    try {
      return _postCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return Post.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
      });
    } catch (error) {
      rethrow;
    }
  }

}