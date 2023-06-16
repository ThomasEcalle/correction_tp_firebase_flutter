import 'package:correction_tp_firebase_flutter/posts/posts_bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post.dart';


class AddPostScreen extends StatelessWidget {
  static const routeName = '/addPost';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  AddPostScreen({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostsBloc, PostsState>(
      listenWhen: _listenWhen,
      listener: _postsBlocListener,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ajouter un Post'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            final loading = state.status == PostsStatus.addingPost;
            if (loading) {
              return const CircularProgressIndicator();
            }

            return FloatingActionButton.extended(
              onPressed: () => _addPost(context),
              label: const Text('Ajouter'),
              icon: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }

  void _addPost(BuildContext context) {
    final title = _titleController.text;
    final description = _descriptionController.text;

    final post = Post(
      title: title,
      description: description,
    );

    context.read<PostsBloc>().add(AddPost(post: post));
  }

  bool _listenWhen(PostsState previous, PostsState current) {
    return previous.status != current.status &&
        (current.status == PostsStatus.errorAddingPost || current.status == PostsStatus.addedPost);
  }

  void _postsBlocListener(BuildContext context, PostsState state) {
    switch (state.status) {
      case PostsStatus.errorAddingPost:
        _showSnackBar(context, 'Erreur lors de l\'ajout du post');
        break;
      case PostsStatus.addedPost:
        _showSnackBar(context, 'Post ajouté avec succès');
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        break;
      default:
        return;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
