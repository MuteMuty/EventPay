import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eventpay/models/card.dart';
import 'package:meta/meta.dart';

import '../../services/backend_service.dart';
import '../../util/either.dart';
import '../../util/failures/backend_failure.dart';
import '../global/global_bloc.dart';

part 'kartice_event.dart';
part 'kartice_state.dart';

class KarticeBloc extends Bloc<_KarticeEvent, KarticeState> {
  final GlobalBloc _globalBloc;
  KarticeBloc({required GlobalBloc globalBloc})
      : _globalBloc = globalBloc,
        super(const KarticeState.initial()) {
    on<_Initialize>(_onInitialize);
    on<Reset>(_onReset);
    on<Update>(_onUpdate);

    add(_Initialize());
  }

  @override
  Future<void> close() async {
    return super.close();
  }

  FutureOr<void> _onInitialize(
    _Initialize event,
    Emitter<KarticeState> emit,
  ) async {
    BackendService _backendService = BackendService.instance;
    Either<BackendFailure, List<EventPayCard>> cardsOrFailure =
        await _backendService.getCards();
    print("cardsOrFailure: $cardsOrFailure");
    if (cardsOrFailure.isError()) return null;
    emit(state.copyWith(initialized: true, cards: cardsOrFailure.value));
  }

  FutureOr<void> _onReset(
    Reset event,
    Emitter<KarticeState> emit,
  ) async {
    emit(const KarticeState.initial());
    add(_Initialize());
  }

  FutureOr<void> _onUpdate(
    Update event,
    Emitter<KarticeState> emit,
  ) async {
    BackendService _backendService = BackendService.instance;
    Either<BackendFailure, List<EventPayCard>> cardsOrFailure =
        await _backendService.getCards();
    print("cardsOrFailure: $cardsOrFailure");
    if (cardsOrFailure.isError()) return null;
    emit(state.copyWith(initialized: true, cards: cardsOrFailure.value));
  }

  // Public API

  Future<void> refresh() async => add(_Initialize());

  void reset() async => add(Reset());
}
