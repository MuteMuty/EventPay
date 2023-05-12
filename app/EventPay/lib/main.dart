import 'dart:io';

import 'package:eventpay/screens/kartica_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bloc/global/global_bloc.dart';
import 'router/router.dart';
import 'router/routes.dart';
import 'services/auth_service.dart';
import 'services/backend_service.dart';
import 'services/http_service.dart';
import 'style/theme.dart';
import 'util/logger.dart';

void main() {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final Logger logger = Logger();

  final HttpService httpService = HttpService();
  AuthService(httpService: httpService);
  BackendService(httpService: httpService);

  final GlobalBloc globalBloc = GlobalBloc(logger: logger);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(VecturaApp(navigatorKey: navigatorKey));
}

class VecturaApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const VecturaApp({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return CupertinoApp(
      title: 'EventPay',
      theme: EPTheme,
      initialRoute: EPRoute.initial,
      onGenerateRoute: EPRouter.onGenerateRoute,
      navigatorKey: navigatorKey,
    );
  }
}
