part of 'sign_in_bloc.dart';

@immutable
class SignInState {
  final String username;
  final String password;

  final bool isLoading;
  final bool? signInSuccessful;
  final Failure? failure;

  const SignInState(
      {required this.username,
      required this.password,
      required this.isLoading,
      required this.signInSuccessful,
      required this.failure});

  const SignInState.initial()
      : username = '',
        password = '',
        isLoading = false,
        signInSuccessful = null,
        failure = null;

  SignInState copyWith({
    String? username,
    String? password,
    bool? isLoading,
    bool? signInSuccessful,
    bool? register,
    Failure? failure,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      signInSuccessful: signInSuccessful,
      failure: failure,
    );
  }
}
