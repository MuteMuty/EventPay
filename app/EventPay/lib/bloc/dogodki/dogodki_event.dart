part of 'dogodki_bloc.dart';

@immutable
abstract class _DogodkiEvent {
  const _DogodkiEvent();
}

class _Initialize extends _DogodkiEvent {
  const _Initialize();
}

class _NewPageFetch extends _DogodkiEvent {
  const _NewPageFetch();
}

class _Refresh extends _DogodkiEvent {
  const _Refresh();
}
