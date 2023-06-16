import 'package:flutter/material.dart';

import '../posts/models/post.dart';
import '../posts/screens/post_detail_screen/post_detail_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    Widget page = const SizedBox.shrink();
    switch (settings.name) {
      case PostDetailScreen.routeName:
        if (settings.arguments is Post) {
          page = PostDetailScreen(post: settings.arguments as Post);
        }
        break;
    }

    return MaterialPageRoute(builder: (context) => page);
  }
}
