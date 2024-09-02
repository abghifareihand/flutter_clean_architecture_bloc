import 'package:go_router/go_router.dart';
import '../../features/user/presentation/pages/detail_user_page.dart';
import '../../features/user/presentation/pages/list_user_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: ListUserPage(),
        ),
        routes: [
          GoRoute(
            path: 'detail-user',
            name: 'detail_user',
            pageBuilder: (context, state) => NoTransitionPage(
              child: DetailUserPage(
                userId: state.extra as String,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
