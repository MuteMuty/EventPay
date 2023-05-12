part of 'register_bloc.dart';

@immutable
abstract class _RegisterEvent {}

class _SubmitRegister extends _RegisterEvent {
  _SubmitRegister();
}

class _EmailChanged extends _RegisterEvent {
  final String value;
  _EmailChanged(this.value);
}

class _PasswordChanged extends _RegisterEvent {
  final String value;
  _PasswordChanged(this.value);
}

class _FirstnameChanged extends _RegisterEvent {
  final String value;
  _FirstnameChanged(this.value);
}

class _LastnameChanged extends _RegisterEvent {
  final String value;
  _LastnameChanged(this.value);
}

class _UsernameChanged extends _RegisterEvent {
  final String value;
  _UsernameChanged(this.value);
}
