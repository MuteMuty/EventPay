import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';
import '../../services/backend_service.dart';
import '../../util/either.dart';
import '../../util/failures/backend_failure.dart';
import '../../util/failures/failure.dart';
import '../global/global_bloc.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  final BackendService _backendService;
  final GlobalBloc _globalBloc;

  ProfilBloc({
    required BackendService backendService,
    required GlobalBloc globalBloc,
  })  : _backendService = backendService,
        _globalBloc = globalBloc,
        super(const ProfilState.initial()) {
    on<_Initialize>(_onInitialize);
    on<_ReloadProfilImage>(_onReloadProfilImage);
    on<_ReloadUser>(_onReloadUser);
    on<_Reset>(_onReset);

    add(const _Initialize());
  }

  @override
  Future<void> close() async {
    return super.close();
  }

  // PUBLIC API
  void reset() async => add(_Reset());

  // HANDLERS

  FutureOr<void> _onInitialize(
    _Initialize event,
    Emitter<ProfilState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    emit(
      state.copyWith(
        isLoading: false,
        initialized: true,
        user: _globalBloc.state.user,
      ),
    );
  }

  FutureOr<void> _onReloadProfilImage(
    _ReloadProfilImage event,
    Emitter<ProfilState> emit,
  ) {
    emit(state.copyWith());
  }

  FutureOr<void> _onReloadUser(
    _ReloadUser event,
    Emitter<ProfilState> emit,
  ) {
    emit(state.copyWith(user: _globalBloc.state.user));
  }

  FutureOr<void> _onReset(
    _Reset event,
    Emitter<ProfilState> emit,
  ) {
    emit(const ProfilState.initial());
    add(const _Initialize());
  }
}
