import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/datasources/local/data_provider.dart';
import '../../data/datasources/remote/firebase_auth_service.dart';
import '../../presentation/features/jobs/views/job_create_view.dart';
import '../../presentation/features/locations/views/location_create_view.dart';
import '../../presentation/features/locations/views/location_details_view.dart';
import '../../presentation/features/locations/views/location_list_view.dart';
import 'pages.dart';

// Feature views
import '../../presentation/common/splash_screen.dart';
import '../../presentation/features/dashboard/views/dashboard_view.dart';
import '../../presentation/features/jobs/views/jobs_view.dart';
import '../../presentation/features/stock/views/stock_view.dart';
import '../../presentation/features/profile/views/profile_view.dart';
import '../../presentation/features/auth/views/login_view.dart';

class AppRouter {
  static AuthService? _authService;
  static DataProvider? _dataProvider;

  AppRouter(AuthService auth, DataProvider data) {
    _authService = auth;
    _dataProvider = data;
  }

  final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey();
  final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey();

  late final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    refreshListenable: Listenable.merge([_authService!, _dataProvider!]),
    initialLocation: Pages.splash.toPath(),
    debugLogDiagnostics: true,

    routes: [
      /// -------------------------------
      /// AUTH ROUTES (No Bottom Nav)
      /// -------------------------------
      GoRoute(
        path: Pages.login.toPath(),
        name: Pages.login.toPathName(),
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: Pages.splash.toPath(),
        name: Pages.splash.toPathName(),
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SplashScreen(),
      ),

      /// -------------------------------
      /// MAIN APP (Bottom Navigation)
      /// -------------------------------
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          return _MainScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: Pages.home.toPath(),
            name: Pages.home.toPathName(),
            builder: (context, state) => const DashboardView(),
            routes: [
              GoRoute(
                path: Pages.locations.toPath(isSubRoute: true),
                name: Pages.locations.toPathName(),
                builder: (context, state) => const LocationListView(),
                routes: [
                  GoRoute(
                    path: Pages.locationCreate.toPath(isSubRoute: true),
                    name: Pages.locationCreate.toPathName(),
                    builder: (context, state) => LocationCreateView(),
                  ),
                  GoRoute(
                    path: Pages.locationDetails.toPath(
                      isSubRoute: true,
                      pathParam: 'id',
                    ),
                    name: Pages.locationDetails.toPathName(),
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
            path: Pages.jobs.toPath(),
            name: Pages.jobs.toPathName(),
            builder: (context, state) => const JobsView(),
            routes: [
              GoRoute(
                path: Pages.jobCreate.toPath(isSubRoute: true),
                name: Pages.jobCreate.toPathName(),
                builder: (context, state) => JobCreateView(),
              ),
            ],
          ),
          GoRoute(
            path: Pages.stock.toPath(),
            name: Pages.stock.toPathName(),
            builder: (context, state) => const StockView(),
          ),
          GoRoute(
            path: Pages.profile.toPath(),
            name: Pages.profile.toPathName(),
            builder: (context, state) => const ProfileView(),
          ),
        ],
      ),
    ],

    /// -------------------------------
    /// AUTH GUARD (Firebase-ready)
    /// -------------------------------
    redirect: (context, state) {
      final bool loggedIn = _authService!.isAuthenticated;
      final bool isInitialized = _dataProvider!.isInitialized;

      final String location = state.matchedLocation;
      final bool isLoggingIn = location == Pages.login.toPath();
      final bool isSplashing = location == Pages.splash.toPath();

      // 1. NOT LOGGED IN
      if (!loggedIn) {
        // If already on login, stay there (null). Otherwise, go to login.
        return isLoggingIn ? null : Pages.login.toPath();
      }

      // 2. LOGGED IN BUT DATA NOT READY
      if (!isInitialized) {
        // If already on splash, stay there (null). Otherwise, go to splash.
        return isSplashing ? null : Pages.splash.toPath();
      }

      // 3. LOGGED IN & DATA READY
      // If they are stuck on login or splash, move them to home.
      if (isLoggingIn || isSplashing) {
        return Pages.home.toPath();
      }

      // 4. PREVENT ACCIDENTAL RE-REDIRECTS
      // If the user is already on a valid app page (Home, Jobs, etc.), return null.
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
    // final String location = GoRouterState.of(context).matchedLocation;
    const tabs = [Pages.home, Pages.jobs, Pages.stock, Pages.profile];

    final location = GoRouterState.of(context).uri.toString();
    int selectedIndex = tabs.indexWhere(
      (page) => location.startsWith(page.toPath()),
    );
    return selectedIndex = selectedIndex < 0 ? 0 : selectedIndex;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Pages.home.go(context);
        break;
      case 1:
        Pages.jobs.go(context);
        break;
      case 2:
        Pages.stock.go(context);
        break;
      case 3:
        Pages.profile.go(context);
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
