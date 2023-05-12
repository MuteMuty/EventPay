part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SubmitSignIn extends SignInEvent {
  SubmitSignIn();
}

class UsernameChanged extends SignInEvent {
  final String value;
  UsernameChanged(this.value);
}

class PasswordChanged extends SignInEvent {
  final String value;
  PasswordChanged(this.value);
}
