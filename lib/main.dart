import 'package:crm_mobile_app/config/routes/router.dart';
import 'package:crm_mobile_app/config/routes/routes.dart';
import 'package:crm_mobile_app/config/theme/app_theme.dart';
import 'package:crm_mobile_app/modules/splash/graph.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppRoutes.splashRoute,
      onGenerateRoute: AppRouter.generateRoute,
      home: SalesScreenCustom(), 
    );
  }
}

