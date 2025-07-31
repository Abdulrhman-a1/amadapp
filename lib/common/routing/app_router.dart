import 'package:amadapp/common/routing/routes.dart';
import 'package:amadapp/features/home/ui/home_screeen.dart';
import 'package:amadapp/features/onBoarding/ui/on_boarding_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardinScreen:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      default:
        return null;
    }
  }
}
