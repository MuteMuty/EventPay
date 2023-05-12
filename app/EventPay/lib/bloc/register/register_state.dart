part of 'register_bloc.dart';

@immutable
class RegisterState {
  final String firstname;
  final String lastname;
  final String email;
  final String username;
  final String password;

  final bool isLoading;
  final bool? isRegistrationSuccessful;
  final Failure? failure;

  const RegisterState({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.username,
    required this.password,
    required this.isLoading,
    required this.isRegistrationSuccessful,
    required this.failure,
  });

  const RegisterState.initial()
      : firstname = '',
        lastname = '',
        email = '',
        username = '',
        password = '',
        isLoading = false,
        isRegistrationSuccessful = null,
        failure = null;

  RegisterState copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? username,
    String? password,
    bool? isLoading,
    bool? isRegistrationSuccessful,
    bool? register,
    Failure? failure,
  }) {
    return RegisterState(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isRegistrationSuccessful: isRegistrationSuccessful,
      failure: failure,
    );
  }
}
