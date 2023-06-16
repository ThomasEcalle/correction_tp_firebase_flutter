import 'package:correction_tp_firebase_flutter/app/app_router.dart';
import 'package:correction_tp_firebase_flutter/posts/repository/posts_data_source/firestore_posts_data_source.dart';
import 'package:correction_tp_firebase_flutter/posts/repository/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../posts/posts_bloc/posts_bloc.dart';
import '../posts/screens/add_post_screen/add_post_screen.dart';
import '../posts/screens/posts_screen/posts_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostsRepository(
        postsDataSource: FirestorePostsDataSource(),
      ),
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (context) => PostsBloc(
              postsRepository: context.read<PostsRepository>(),
            ),
            child: MaterialApp(
              routes: {
                PostsScreen.routeName: (context) => const PostsScreen(),
                AddPostScreen.routeName: (context) => AddPostScreen(),
              },
              onGenerateRoute: AppRouter.onGenerateRoute,
            ),
          );
        },
      ),
    );
  }
}
