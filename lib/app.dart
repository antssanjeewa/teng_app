import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/local/data_provider.dart';
import 'data/datasources/remote/firebase_auth_service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    // 1. Get the providers once
    final authService = Provider.of<AuthService>(context, listen: false);
    final dataProvider = Provider.of<DataProvider>(context, listen: false);

    // 2. Initialize the router once
    _appRouter = AppRouter(authService, dataProvider);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Tisera Engineering',

        /// Theme
        theme: AppTheme.darkTheme,

        /// Routing
        routerConfig: _appRouter.router,
      ),
    );
  }
}
