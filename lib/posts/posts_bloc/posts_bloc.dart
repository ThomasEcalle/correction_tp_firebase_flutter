import 'package:bloc/bloc.dart';
import 'package:correction_tp_firebase_flutter/posts/repository/posts_repository.dart';
import 'package:meta/meta.dart';

import '../models/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;

  PostsBloc({required this.postsRepository}) : super(const PostsState()) {
    on<GetAllPosts>(_getAllPosts);
    on<AddPost>(_addPost);
    on<UpdatePost>(_updatePost);
  }

  void _getAllPosts(event, emit) async {
    emit(state.copyWith(status: PostsStatus.fetchingPosts));

    try {
      final postsStream = postsRepository.getAllPosts();
      await emit.forEach(postsStream, onData: (posts) {
        return state.copyWith(status: PostsStatus.fetchedPosts, posts: posts);
      });
    } catch (error) {
      emit(state.copyWith(status: PostsStatus.errorFetchingPosts));
    }
  }

  void _addPost(event, emit) async {
    emit(state.copyWith(status: PostsStatus.addingPost));

    try {
      await postsRepository.addPost(event.post);
      emit(state.copyWith(status: PostsStatus.addedPost));
    } catch (error) {
      emit(state.copyWith(status: PostsStatus.errorAddingPost));
    }
  }

  void _updatePost(event, emit) async {
    emit(state.copyWith(status: PostsStatus.updatingPost));

    try {
      await postsRepository.editPost(event.post);
      emit(state.copyWith(status: PostsStatus.updatedPost));
    } catch (error) {
      emit(state.copyWith(status: PostsStatus.errorUpdatingPost));
    }
  }
}
