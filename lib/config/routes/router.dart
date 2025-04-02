import 'package:crm_mobile_app/config/routes/arguments/lead_details_arguments.dart';
import 'package:crm_mobile_app/config/routes/error_route.dart';
import 'package:crm_mobile_app/config/routes/routes.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_view.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view/lead_profile_screen.dart';
import 'package:crm_mobile_app/modules/login/presentation/view/login_screen.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view/campaign_detailed_view/view_campaign_detailed_view.dart';
import 'package:crm_mobile_app/modules/profile/presentation/view/profile_view.dart';
import 'package:crm_mobile_app/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppRoutes.dashboardRoute:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case AppRoutes.viewCampaignDetailedRoute:
        return MaterialPageRoute(builder: (_) => ViewCampaignDetailedView());
      case AppRoutes.profileRoute:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case AppRoutes.leadProfileScreen:
        LeadDetailsArguments leadDetailsArguments =
            settings.arguments as LeadDetailsArguments;
        return MaterialPageRoute(
            builder: (_) => LeadDetailsScreen(
                  leadName: leadDetailsArguments.leadName,
                  leadEmailId: leadDetailsArguments.leadEmailId,
                  leadContact: leadDetailsArguments.leadContact,
                  leadStatus: leadDetailsArguments.leadStatus,
                  leadChannel: leadDetailsArguments.leadChannel,
                  leadID: leadDetailsArguments.leadID,
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => ErrorScreen(
            routeName: settings.name,
          ),
        );
    }
  }
}
