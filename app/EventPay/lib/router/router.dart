import 'package:eventpay/screens/fillup_screen.dart';
import 'package:flutter/material.dart';

import '../screens/dogodki_details.dart';
import '../screens/kartica_details.dart';
import '../screens/root.dart';
import '../screens/tabs/dogodki.dart';
import '../screens/tabs/kartice.dart';
import '../screens/registration.dart';
import '../screens/sign_in.dart';
import '../screens/splash.dart';
import '../screens/tabs/profil.dart';
import '../util/logger.dart';
import 'routes.dart';

/// Provides [onGenerateRoute] function and stores current topmost route.
abstract class EPRouter {
  /// Transforms [settings] into corresponding route.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Logger.instance.info(
      'EventPayRouter.onGenerateRoute',
      'pushing route ${settings.name}',
    );

    switch (settings.name) {
      case EPRoute.initial:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case EPRoute.signIn:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => SignInScreen(
            args: settings.arguments as SignInScreenArgs,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 850),
        );
      case EPRoute.registration:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => RegistrationScreen(
            args: settings.arguments as RegistrationScreenArgs,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 850),
        );
      case EPRoute.root:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => const RootScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );

      case EPRoute.kartice:
        return PageRouteBuilder(
          fullscreenDialog: true,
          reverseTransitionDuration: const Duration(milliseconds: 0),
          transitionDuration: const Duration(milliseconds: 0),
          pageBuilder: (context, _, __) => const KarticeTab(),
        );
      case EPRoute.dogodki:
        return PageRouteBuilder(
          fullscreenDialog: true,
          reverseTransitionDuration: const Duration(milliseconds: 0),
          transitionDuration: const Duration(milliseconds: 0),
          pageBuilder: (context, _, __) => const DogodkiTab(),
        );
      case EPRoute.profil:
        return PageRouteBuilder(
          fullscreenDialog: true,
          reverseTransitionDuration: const Duration(milliseconds: 0),
          transitionDuration: const Duration(milliseconds: 0),
          pageBuilder: (context, _, __) => const ProfilTab(),
        );

      case EPRoute.karticaDetailsScreen:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => KarticaDetailsScreen(
            args: settings.arguments as KarticaDetailsScreenArgs,
          ),
        );
      case EPRoute.dogodkiDetailsScreen:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => DogodkiDetailsScreen(
            args: settings.arguments as DogodkiDetailsScreenArgs,
<<<<<<< Updated upstream
          ),);
=======
          ),
        );
>>>>>>> Stashed changes

      case EPRoute.fillUpCard:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => FillupScreen(
            args: settings.arguments as FillupScreenArgs,
          ),
        );
    }

    return null;
  }
}
