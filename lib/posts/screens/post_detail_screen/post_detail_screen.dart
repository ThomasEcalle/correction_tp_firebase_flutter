import 'package:correction_tp_firebase_flutter/posts/models/post.dart';
import 'package:correction_tp_firebase_flutter/posts/posts_bloc/posts_bloc.dart';
import 'package:correction_tp_firebase_flutter/posts/screens/post_detail_screen/edit_post_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailScreen extends StatefulWidget {
  static const routeName = '/postDetail';

  static void navigateTo(BuildContext context, Post post) {
    Navigator.of(context).pushNamed(routeName, arguments: post);
  }

  const PostDetailScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  Post get post => widget.post;

  bool _isEditing = false;
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: post.title);
    _descriptionController = TextEditingController(text: post.description);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostsBloc, PostsState>(
      listener: _postsBlocListener,
      child: Scaffold(
        appBar: AppBar(
          title: Text(post.title),
          actions: [
            IconButton(
              onPressed: _toggleEditing,
              icon: Icon(_isEditing ? Icons.edit : Icons.edit_off),
            ),
          ],
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
                enabled: _isEditing,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                enabled: _isEditing,
              ),
            ],
          ),
        ),
        floatingActionButton: EditPostButton(
          isEditing: _isEditing,
          onEdit: () => _savePost(context),
        ),
      ),
    );
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _savePost(BuildContext context) {
    final newTitle = _titleController?.text;
    final newDescription = _descriptionController?.text;

    final newPost = post.copyWith(
      title: newTitle,
      description: newDescription,
    );

    context.read<PostsBloc>().add(UpdatePost(post: newPost));
  }

  void _postsBlocListener(BuildContext context, PostsState state) {
    switch (state.status) {
      case PostsStatus.updatedPost:
        _showSnackBar(context, 'Post mis à jour');
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }

        break;
      case PostsStatus.errorUpdatingPost:
        _showSnackBar(context, 'Erreur lors de la mise à jour du post');
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
