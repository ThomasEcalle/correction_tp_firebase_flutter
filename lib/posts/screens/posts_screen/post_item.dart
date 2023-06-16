import 'package:flutter/material.dart';

import '../../models/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.post,
    this.onTap,
  }) : super(key: key);

  final Post post;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.description),
      onTap: onTap,
    );
  }
}
