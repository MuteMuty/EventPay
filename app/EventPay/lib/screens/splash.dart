import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/splash_screen/splashscreen_bloc.dart';
import '../services/auth_service.dart';
import '../style/colors.dart';
import '../style/images.dart';
import 'sign_in.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashScreenBloc>(
      create: (BuildContext context) => SplashScreenBloc(
        globalBloc: GlobalBloc.instance,
        authService: AuthService.instance,
      ),
      child: const _SplashScreen(),
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashScreenBloc, SplashScreenState>(
        listener: (context, state) {
      if (state.initialized) {
        Navigator.pushReplacementNamed(
          context,
          state.pushRoute!,
          arguments: const SignInScreenArgs(
            username: '',
            password: '',
          ),
        );
        return;
      }
    }, builder: (context, state) {
      return CupertinoPageScaffold(
        child: Center(
          child: Hero(
            tag: 'logo',
            child: SvgPicture.asset(
              EPImage.logo,
            ),
          ),
        ),
      );
    });
  }
}
