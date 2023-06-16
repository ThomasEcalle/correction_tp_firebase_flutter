import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../posts_bloc/posts_bloc.dart';

class EditPostButton extends StatelessWidget {
  const EditPostButton({
    Key? key,
    this.isEditing = false,
    this.onEdit,
  }) : super(key: key);

  final bool isEditing;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    Color color = isEditing ? Colors.blue : Colors.grey;

    return BlocBuilder<PostsBloc, PostsState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        final loading = state.status == PostsStatus.updatingPost;
        final child = loading ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.save);
        return FloatingActionButton(
          onPressed: isEditing ? onEdit : null,
          backgroundColor: color,
          child: child,
        );
      },
    );
  }
}
