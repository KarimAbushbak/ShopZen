import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../data/repos/auth_repository.dart';
import 'package:flutter/material.dart';

@immutable
class LoginFormFieldState {
  final String text;
  final bool isFocused;
  final bool isTouched;
  final bool isValid;

  const LoginFormFieldState({
    this.text = '',
    this.isFocused = false,
    this.isTouched = false,
    this.isValid = false,
  });

  LoginFormFieldState copyWith({
    String? text,
    bool? isFocused,
    bool? isTouched,
    bool? isValid,
  }) {
    return LoginFormFieldState(
      text: text ?? this.text,
      isFocused: isFocused ?? this.isFocused,
      isTouched: isTouched ?? this.isTouched,
      isValid: isValid ?? this.isValid,
    );
  }
}

@immutable
class LoginFormState {
  final LoginFormFieldState email;
  final LoginFormFieldState password;
  final bool isFormValid;
  final bool isLoading;

  const LoginFormState({
    this.email = const LoginFormFieldState(),
    this.password = const LoginFormFieldState(),
    this.isFormValid = false,
    this.isLoading = false,
  });

  LoginFormState copyWith({
    LoginFormFieldState? email,
    LoginFormFieldState? password,
    bool? isFormValid,
    bool? isLoading,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LoginFormCubit extends Cubit<LoginFormState> {
  final AuthRepository authRepository;

  LoginFormCubit({required this.authRepository})
    : super(const LoginFormState());

  bool _emailValidator(String text) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(text);
  }

  bool _passwordValidator(String text) => text.length >= 6;

  void onEmailChanged(String text) {
    final isValid = _emailValidator(text);

    emit(
      state.copyWith(
        email: state.email.copyWith(text: text, isValid: isValid),
        isFormValid: _validateForm(
          email: state.email.copyWith(text: text, isValid: isValid),
          password: state.password,
        ),
      ),
    );
  }

  void onPasswordChanged(String text) {
    final isValid = _passwordValidator(text);

    emit(
      state.copyWith(
        password: state.password.copyWith(text: text, isValid: isValid),
        isFormValid: _validateForm(
          email: state.email,
          password: state.password.copyWith(text: text, isValid: isValid),
        ),
      ),
    );
  }

  void onEmailFocusChanged(bool isFocused) {
    emit(
      state.copyWith(
        email: state.email.copyWith(
          isFocused: isFocused,
          isTouched: !isFocused ? true : state.email.isTouched,
        ),
      ),
    );
  }

  void onPasswordFocusChanged(bool isFocused) {
    emit(
      state.copyWith(
        password: state.password.copyWith(
          isFocused: isFocused,
          isTouched: !isFocused ? true : state.password.isTouched,
        ),
      ),
    );
  }

  bool _validateForm({
    required LoginFormFieldState email,
    required LoginFormFieldState password,
  }) {
    return email.isValid && password.isValid;
  }

  Future<bool> login({required BuildContext context}) async {
    emit(state.copyWith(isLoading: true));
    final result = await authRepository.login(
      email: state.email.text,
      password: state.password.text,
    );
    emit(state.copyWith(isLoading: false));
    if (!result) {
      // Show error snackbar here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please check your credentials.')),
      );
    }
    return result;
  }
}
