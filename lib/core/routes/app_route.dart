import 'package:flutter_clean_architecture_bloc/features/profile/domain/entities/profile.dart';
import 'package:flutter_clean_architecture_bloc/features/profile/presentation/pages/all_user_page.dart';
import 'package:flutter_clean_architecture_bloc/features/profile/presentation/pages/detail_user_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'all_users',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AllUserPage(),
        ),
        // sub route
        routes: [
          GoRoute(
            path: 'detail-user',
            name: 'detail_user',
            pageBuilder: (context, state) => NoTransitionPage(
              child: DetailUserPage(
                userId: state.extra as int,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
