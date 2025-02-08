import 'package:crm_mobile_app/config/routes/router.dart';
import 'package:crm_mobile_app/config/routes/routes.dart';
import 'package:crm_mobile_app/config/theme/app_theme.dart';
import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart' as di;
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_channel_widget.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_header_view.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_tabs_widget.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_view.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view_model/bottom_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:crm_mobile_app/modules/login/presentation/view/login_screen.dart';
import 'package:crm_mobile_app/modules/login/presentation/view_model/login_bloc/login_bloc.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view/campaign_detailed_view/view_campaign_detailed_view.dart';
import 'package:crm_mobile_app/modules/profile/presentation/view/profile_view.dart';
import 'package:crm_mobile_app/modules/splash/graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


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
      home: LoginScreen(),
    );
  }
}
