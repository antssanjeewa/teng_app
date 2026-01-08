import 'package:Tisera_Engineering/presentation/features/locations/views/location_details_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/features/locations/views/location_list_view.dart';
import 'route_names.dart';

// Feature views
import '../../presentation/common/splash_screen.dart';
import '../../presentation/features/dashboard/views/dashboard_view.dart';
import '../../presentation/features/jobs/views/jobs_view.dart';
import '../../presentation/features/stock/views/stock_view.dart';
import '../../presentation/features/profile/views/profile_view.dart';
import '../../presentation/features/auth/views/login_view.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,

    routes: [
      /// -------------------------------
      /// AUTH ROUTES (No Bottom Nav)
      /// -------------------------------
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.login,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splash,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SplashScreen(),
      ),

      /// -------------------------------
      /// MAIN APP (Bottom Navigation)
      /// -------------------------------
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return _MainScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: RouteNames.home,
            name: RouteNames.home,
            builder: (context, state) => const DashboardView(),
            routes: [
              GoRoute(
                path: 'locations',
                name: RouteNames.locations,
                builder: (context, state) => const LocationListView(),
                routes: [
                  GoRoute(
                    path: ':id',
                    name: RouteNames.locationDetail,
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return LocationDetailsView(id);
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: RouteNames.jobs,
            name: RouteNames.jobs,
            builder: (context, state) => const JobsView(),
          ),
          GoRoute(
            path: RouteNames.stock,
            name: RouteNames.stock,
            builder: (context, state) => const StockView(),
          ),
          GoRoute(
            path: RouteNames.profile,
            name: RouteNames.profile,
            builder: (context, state) => const ProfileView(),
          ),
        ],
      ),
    ],

    /// -------------------------------
    /// AUTH GUARD (Firebase-ready)
    /// -------------------------------
    redirect: (context, state) {
      // TODO: Replace with FirebaseAuth check
      // final bool isLoggedIn = false;

      // final bool isLoggingIn = state.matchedLocation == RouteNames.login;

      // if (!isLoggedIn && !isLoggingIn) {
      //   return RouteNames.login;
      // }

      return null;
    },
  );
}

/// ------------------------------------------------
/// MAIN SCAFFOLD WITH BOTTOM NAVIGATION
/// ------------------------------------------------
class _MainScaffold extends StatelessWidget {
  final Widget child;

  const _MainScaffold({required this.child});

  int _calculateIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;

    switch (location) {
      case RouteNames.home:
        return 0;
      case RouteNames.jobs:
        return 1;
      case RouteNames.stock:
        return 2;
      case RouteNames.profile:
        return 3;
      default:
        return 0;
    }
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.home);
        break;
      case 1:
        context.go(RouteNames.jobs);
        break;
      case 2:
        context.go(RouteNames.stock);
        break;
      case 3:
        context.go(RouteNames.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateIndex(context),
        onTap: (index) => _onTap(context, index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline_rounded),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
