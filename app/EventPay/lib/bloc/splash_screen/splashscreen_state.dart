part of 'splashscreen_bloc.dart';

@immutable
class SplashScreenState {
  final bool initialized;
  final String? pushRoute;

  const SplashScreenState({
    required this.initialized,
    required this.pushRoute,
  });

  const SplashScreenState.initial()
      : initialized = false,
        pushRoute = null;

  SplashScreenState copyWith({
    bool? initialized,
    String? pushRoute,
    bool? connection,
  }) {
    return SplashScreenState(
      initialized: initialized ?? this.initialized,
      pushRoute: pushRoute,
    );
  }
}
