part of 'kartice_bloc.dart';

@immutable
abstract class _KarticeEvent {}

class _Initialize extends _KarticeEvent {}

class Reset extends _KarticeEvent {}

class Update extends _KarticeEvent {
  KarticeState state;

  Update(this.state);
}
