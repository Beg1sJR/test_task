import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:test_task/features/auth/presentation/pages/login/launcher.dart';
import 'package:test_task/features/auth/presentation/pages/register/register.dart';
import 'package:test_task/features/home/presentation/logic/bloc/details_bloc.dart';
import 'package:test_task/features/home/presentation/pages/details/details.dart';
import 'package:test_task/features/home/presentation/pages/home.dart';
import 'package:test_task/features/products/presentation/pages/products.dart';
import 'package:test_task/features/profile/presentation/pages/profile.dart';
import 'package:test_task/features/profile/presentation/pages/settings/settings.dart';
import 'package:test_task/features/scaffold_with_nav_bar/scaffold_with_nav_bar.dart';
import 'package:test_task/injection.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'homeNav',
);
final GlobalKey<NavigatorState> _productsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'productshNav');

final GlobalKey<NavigatorState> _profileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'profileNav');

class AppRouter {
  final GoRouter router = GoRouter(
    observers: [TalkerRouteObserver(getIt<Talker>())],
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginLauncherPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) =>
            const RegisterPage(),
      ),

      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              return ScaffoldWithNavBar(navigationShell: navigationShell);
            },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            observers: [TalkerRouteObserver(getIt<Talker>())],
            navigatorKey: _homeNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/home',
                builder: (BuildContext context, GoRouterState state) =>
                    const HomePage(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details/:id',
                    builder: (BuildContext context, GoRouterState state) {
                      final id = int.parse(state.pathParameters['id']!);
                      return BlocProvider(
                        create: (_) =>
                            DetailsBloc()..add(LoadProductDetails(id)),
                        child: DetailsPage(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            observers: [TalkerRouteObserver(getIt<Talker>())],
            navigatorKey: _productsNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/products',
                builder: (BuildContext context, GoRouterState state) =>
                    const ProductsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            observers: [TalkerRouteObserver(getIt<Talker>())],
            navigatorKey: _profileNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/profile',
                builder: (BuildContext context, GoRouterState state) =>
                    const ProfilePage(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'settings',
                    builder: (BuildContext context, GoRouterState state) {
                      return const SettingsPage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
