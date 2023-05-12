import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';

import '../../models/user.dart';
import '../../router/routes.dart';
import '../../services/auth_service.dart';
import '../../util/either.dart';
import '../../util/failures/backend_failure.dart';
import '../global/global_bloc.dart';

part 'splashscreen_event.dart';
part 'splashscreen_state.dart';

class SplashScreenBloc extends Bloc<_SplashScreenEvent, SplashScreenState> {
  final GlobalBloc _globalBloc;
  final AuthService _authService;
  SplashScreenBloc({
    required GlobalBloc globalBloc,
    required AuthService authService,
  })  : _globalBloc = globalBloc,
        _authService = authService,
        super(const SplashScreenState.initial()) {
    on<_Initialize>(_onInitialize);

    add(_Initialize());
  }

  @override
  Future<void> close() async {
    return super.close();
  }

  // Public API

  void retry() => add(_Initialize());

  // Handlers

  FutureOr<void> _onInitialize(
    _Initialize event,
    Emitter<SplashScreenState> emit,
  ) async {
    final List results = await Future.wait(<Future>[
      _initialize(),
      // This is taking too long
      //Future.delayed(const Duration(seconds: 2)),
    ]);

    if (results.first == null) {
      emit(state.copyWith(
        pushRoute: EPRoute.signIn,
        initialized: true,
      ));
      return;
    }

    emit(state.copyWith(
      initialized: true,
      pushRoute: results.first,
    ));
  }

  // Helpers

  Future<String?> _initialize() async {
    final LocalStorage storage = LocalStorage('user');

    EventPayUser? user = await storage.getItem('user');
    print("USER: $user");

    if (user == null) {
      return EPRoute.signIn;
    }
    return EPRoute.root;
  }
}
