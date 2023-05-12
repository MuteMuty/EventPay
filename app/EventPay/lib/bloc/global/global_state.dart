part of 'global_bloc.dart';

@immutable
class GlobalState {
  final EventPayUser? user;

  const GlobalState({
    required this.user,
  });

  const GlobalState.initial() : user = null;

  GlobalState copyWith({
    EventPayUser? user,
  }) {
    return GlobalState(
      user: user ?? this.user,
    );
  }
}
