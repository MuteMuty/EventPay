import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eventpay/bloc/global/global_bloc.dart';
import 'package:eventpay/models/event.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../services/backend_service.dart';
import '../../util/either.dart';
import '../../util/failures/backend_failure.dart';
import '../../util/failures/failure.dart';

part 'dogodki_event.dart';
part 'dogodki_state.dart';

class DogodkiBloc extends Bloc<_DogodkiEvent, DogodkiState> {
  final BackendService _backendService;

  DogodkiBloc({required BackendService backendService})
      : _backendService = backendService,
        super(const DogodkiState.initial()) {
    on<_Initialize>(_onInitialize);
    on<_NewPageFetch>(_onNewPageFetch);
    on<_Refresh>(_onRefresh);

    add(const _Initialize());
  }

  @override
  Future<void> close() {
    return super.close();
  }

  // Public API

  Future<void> refresh() async => add(const _Refresh());

  // Handlers

  FutureOr<void> _onInitialize(
    _Initialize event,
    Emitter<DogodkiState> emit,
  ) async {
    BackendService _backendService = BackendService.instance;
    Either<BackendFailure, List<EventPayEvent>> cardsOrFailure =
        await _backendService.getEvents();
    print("cardsOrFailure: $cardsOrFailure");
    if (cardsOrFailure.isError()) return null;
    emit(state.copyWith(initialized: true, cards: cardsOrFailure.value));
  }

  FutureOr<void> _onNewPageFetch(
    _NewPageFetch event,
    Emitter<DogodkiState> emit,
  ) async {
    add(const _Initialize());
  }

  FutureOr<void> _onRefresh(
    _Refresh event,
    Emitter<DogodkiState> emit,
  ) async {
    //emit(state.copyWith(page: 1, failure: null));
  }
}
