import 'package:crm_mobile_app/config/routes/router.dart';
import 'package:crm_mobile_app/config/routes/routes.dart';
import 'package:crm_mobile_app/config/theme/app_theme.dart';
import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart'
    as di;
import 'package:crm_mobile_app/core/utils/alice.dart';
import 'package:crm_mobile_app/modules/login/presentation/view/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  di.init();
  runApp(MyApp());
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

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
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      //navigatorKey: alice.getNavigatorKey(),
      home: LoginScreen(),
    );
  }
}
