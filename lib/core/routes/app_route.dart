import 'package:go_router/go_router.dart';
import '../../features/profile/presentation/pages/all_profile_page.dart';
import '../../features/profile/presentation/pages/detail_profile_page.dart';
import '../../features/user/presentation/pages/detail_user_page.dart';
import '../../features/user/presentation/pages/home_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // GoRoute(
      //   path: '/',
      //   pageBuilder: (context, state) => const NoTransitionPage(
      //     child: HomePage(),
      //   ),
      //   routes: [
      //     GoRoute(
      //       path: 'detail-user',
      //       name: 'detail_user',
      //       pageBuilder: (context, state) => NoTransitionPage(
      //         child: DetailUserPage(
      //           userId: state.extra as String,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

      GoRoute(
        path: '/',
        name: 'all_users',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AllProfilePage(),
        ),
        // sub route
        routes: [
          GoRoute(
            path: 'detail-user',
            name: 'detail_user',
            pageBuilder: (context, state) => NoTransitionPage(
              child: DetailProfilePage(
                userId: state.extra as int,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
