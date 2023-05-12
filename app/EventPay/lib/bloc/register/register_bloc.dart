import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../util/either.dart';
import '../../util/failures/backend_failure.dart';
import '../../util/failures/failure.dart';
import '../../util/failures/validation_failure.dart';
import '../../util/validator.dart';
import '../global/global_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<_RegisterEvent, RegisterState> {
  final GlobalBloc _globalBloc;
  final AuthService _authService;

  RegisterBloc({
    required GlobalBloc globalBloc,
    required AuthService authService,
  })  : _globalBloc = globalBloc,
        _authService = authService,
        super(const RegisterState.initial()) {
    on<_SubmitRegister>(_onSubmitRegister);
    on<_EmailChanged>(_onEmailChanged);
    on<_PasswordChanged>(_onPasswordChanged);
    on<_FirstnameChanged>(_onFirstnameChanged);
    on<_LastnameChanged>(_onLastnameChanged);
    on<_UsernameChanged>(_onUsernameChanged);
  }

  // Public API

  void register() => add(_SubmitRegister());
  void emailChanged(String value) => add(_EmailChanged(value));
  void passwordChanged(String value) => add(_PasswordChanged(value));
  void firstnameChanged(String value) => add(_FirstnameChanged(value));
  void lastnameChanged(String value) => add(_LastnameChanged(value));
  void usernameChanged(String value) => add(_UsernameChanged(value));

  // Handlers

  FutureOr<void> _onSubmitRegister(
    _SubmitRegister event,
    Emitter<RegisterState> emit,
  ) async {
    if (!EPValidator.isValidEmail(state.email)) {
      emit(state.copyWith(failure: const EmailValidationFailure()));
      return;
    }
    if (!EPValidator.isValidPassword(state.password)) {
      emit(state.copyWith(failure: const PasswordValidationFailure()));
      return;
    }
    if (!EPValidator.isValidName(state.firstname)) {
      emit(state.copyWith(failure: const NameValidationFailure()));
      return;
    }
    if (!EPValidator.isValidName(state.lastname)) {
      emit(state.copyWith(failure: const NameValidationFailure()));
      return;
    }
    if (!EPValidator.isValidText(state.username)) {
      emit(state.copyWith(failure: const UsernameValidationFailure()));
      return;
    }

    emit(state.copyWith(isLoading: true));

    final Either<BackendFailure, EventPayUser> userOrFailure =
        await _authService.register(state.firstname, state.lastname,
            state.email, state.username, state.password);

    if (userOrFailure.isError()) {
      emit(state.copyWith(
        isLoading: false,
        isRegistrationSuccessful: false,
        failure: userOrFailure.error,
      ));
      return;
    }

    _globalBloc.updateUser(userOrFailure.value);
    emit(state.copyWith(isLoading: false, isRegistrationSuccessful: true));
  }

  FutureOr<void> _onEmailChanged(
    _EmailChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(email: event.value));
  }

  FutureOr<void> _onPasswordChanged(
    _PasswordChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(password: event.value));
  }

  FutureOr<void> _onFirstnameChanged(
    _FirstnameChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(firstname: event.value));
  }

  FutureOr<void> _onLastnameChanged(
    _LastnameChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(lastname: event.value));
  }

  FutureOr<void> _onUsernameChanged(
    _UsernameChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(username: event.value));
  }
}
