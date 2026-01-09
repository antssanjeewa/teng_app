/// Route name constants used throughout the app.
class RouteNames {
  RouteNames._();

  // Auth
  static const String splash = '/splash';
  static const String login = '/login';

  // Main shell (bottom navigation)
  static const String home = '/';

  static const String jobs = '/jobs';
  static const String jobCreate = '/jobs/create';

  static const String locations = '/locations';
  static const String locationCreate = '/locations/create';
  static const String locationDetail = 'view/:id';

  static const String stock = '/stock';
  static const String profile = '/profile';
}
