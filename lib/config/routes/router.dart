import 'package:crm_mobile_app/config/routes/error_route.dart';
import 'package:crm_mobile_app/config/routes/routes.dart';
import 'package:crm_mobile_app/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => ErrorScreen(
            routeName: settings.name,
          ),
        );
    }
  }
}
