import 'package:correction_tp_firebase_flutter/posts/posts_bloc/posts_bloc.dart';
import 'package:correction_tp_firebase_flutter/posts/repository/posts_data_source/posts_data_source.dart';
import 'package:correction_tp_firebase_flutter/posts/repository/posts_repository.dart';
import 'package:correction_tp_firebase_flutter/posts/screens/posts_screen/post_item.dart';
import 'package:correction_tp_firebase_flutter/posts/screens/posts_screen/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'posts_data_source_mocks/empty_posts_data_source.dart';
import 'posts_data_source_mocks/error_posts_data_source.dart';
import 'posts_data_source_mocks/loading_then_empty_posts_data_source.dart';
import 'posts_data_source_mocks/success_posts_data_source.dart';

Widget _buildTestablePostsScreen(PostsDataSource postsDataSource) {
  return RepositoryProvider(
    create: (context) => PostsRepository(postsDataSource: postsDataSource),
    child: Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => PostsBloc(postsRepository: context.read<PostsRepository>()),
          child: const MaterialApp(
            home: PostsScreen(),
          ),
        );
      },
    ),
  );
}

void main() {
  group('$PostsScreen', () {
    testWidgets('Should display empty message when no posts are fetched', (widgetTester) async {
      await widgetTester.pumpWidget(_buildTestablePostsScreen(EmptyPostsDataSource()));
      await widgetTester.pumpAndSettle();
      expect(find.text('No posts'), findsOneWidget);
    });

    testWidgets('Should display error message and retry button when error is thrown fetching posts',
        (widgetTester) async {
      await widgetTester.pumpWidget(_buildTestablePostsScreen(ErrorPostsDataSource()));
      await widgetTester.pumpAndSettle();

      expect(find.text('An error occured'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Should display loading indicator for 2 seconds when posts are being fetched then empty message',
        (widgetTester) async {
      await widgetTester.pumpWidget(_buildTestablePostsScreen(LoadingThenEmptyPostsDataSource()));
      await widgetTester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await widgetTester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('No posts'), findsOneWidget);
    });

    testWidgets('Should display posts when posts are fetched', (widgetTester) async {
      await widgetTester.pumpWidget(_buildTestablePostsScreen(SuccessPostsDataSource()));
      await widgetTester.pumpAndSettle();

      expect(find.text('Test post 1 title'), findsOneWidget);
      expect(find.text('Test post 1 description'), findsOneWidget);

      expect(find.text('Test post 2 title'), findsOneWidget);
      expect(find.text('Test post 2 description'), findsOneWidget);

      expect(find.text('Test post 3 title'), findsOneWidget);
      expect(find.text('Test post 3 description'), findsOneWidget);

      expect(find.byType(PostItem), findsNWidgets(3));
    });
  });
}
