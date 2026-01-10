import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/local/data_provider.dart';
import 'data/datasources/remote/firebase_auth_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    final router = AppRouter(authService, dataProvider).router;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Tisera Engineering',

        /// Theme
        theme: AppTheme.darkTheme,

        /// Routing
        routerConfig: router,
      ),
    );
  }
}
