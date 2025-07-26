import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repos/auth_repository.dart';

@immutable
class SignupFormFieldState {
  final String text;
  final bool isFocused;
  final bool isTouched;
  final bool isValid;
  final bool isTermsAccepted;

  const SignupFormFieldState({
    this.text = '',
    this.isFocused = false,
    this.isTouched = false,
    this.isValid = false,
    this.isTermsAccepted = false,
  });

  SignupFormFieldState copyWith({
    String? text,
    bool? isFocused,
    bool? isTouched,
    bool? isValid,

  }) {
    return SignupFormFieldState(
      text: text ?? this.text,
      isFocused: isFocused ?? this.isFocused,
      isTouched: isTouched ?? this.isTouched,
      isValid: isValid ?? this.isValid,
    );
  }
}

@immutable
class SignupFormState {
  final SignupFormFieldState name;
  final SignupFormFieldState email;
  final SignupFormFieldState phone;
  final SignupFormFieldState password;
  final SignupFormFieldState confirmPassword;
  final bool isFormValid;
  final bool isLoading;
  final bool isTermsAccepted;

  const SignupFormState({
    this.name = const SignupFormFieldState(),
    this.email = const SignupFormFieldState(),
    this.phone = const SignupFormFieldState(),
    this.password = const SignupFormFieldState(),
    this.confirmPassword = const SignupFormFieldState(),
    this.isFormValid = false,
    this.isLoading = false,
    this.isTermsAccepted = false,
  });

  SignupFormState copyWith({
    SignupFormFieldState? name,
    SignupFormFieldState? email,
    SignupFormFieldState? phone,
    SignupFormFieldState? password,
    SignupFormFieldState? confirmPassword,
    bool? isFormValid,
    bool? isLoading,
    bool? isTermsAccepted,
  }) {
    return SignupFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
    );
  }
}

typedef Validator = bool Function(String);

class SignupFormCubit extends Cubit<SignupFormState> {
  final AuthRepository authRepository;

  SignupFormCubit({required this.authRepository}) : super(const SignupFormState());

  bool _nameValidator(String text) => text.trim().length >= 4;
  bool _emailValidator(String text) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(text);
  }
  bool _phoneValidator(String text) => RegExp(r'^\d{7,24}$').hasMatch(text);
  bool _passwordValidator(String text) => text.length >= 6;
  bool _confirmPasswordValidator(String text, String password) => text == password && text.isNotEmpty;

  void onNameChanged(String text) {
    final isValid = _nameValidator(text);
    emit(state.copyWith(
      name: state.name.copyWith(text: text, isValid: isValid),
      isFormValid: _validateForm(
        name: state.name.copyWith(text: text, isValid: isValid),
        email: state.email,
        phone: state.phone,
        password: state.password,
        confirmPassword: state.confirmPassword,
      ),
    ));
  }

  void onEmailChanged(String text) {
    final isValid = _emailValidator(text);
    emit(state.copyWith(
      email: state.email.copyWith(text: text, isValid: isValid),
      isFormValid: _validateForm(
        name: state.name,
        email: state.email.copyWith(text: text, isValid: isValid),
        phone: state.phone,
        password: state.password,
        confirmPassword: state.confirmPassword,
      ),
    ));
  }

  void onPhoneChanged(String text) {
    final isValid = _phoneValidator(text);
    emit(state.copyWith(
      phone: state.phone.copyWith(text: text, isValid: isValid),
      isFormValid: _validateForm(
        name: state.name,
        email: state.email,
        phone: state.phone.copyWith(text: text, isValid: isValid),
        password: state.password,
        confirmPassword: state.confirmPassword,
      ),
    ));
  }

  void onPasswordChanged(String text) {
    final isValid = _passwordValidator(text);
    final confirmPasswordValid = _confirmPasswordValidator(state.confirmPassword.text, text);
    emit(state.copyWith(
      password: state.password.copyWith(text: text, isValid: isValid),
      confirmPassword: state.confirmPassword.copyWith(isValid: confirmPasswordValid),
      isFormValid: _validateForm(
        name: state.name,
        email: state.email,
        phone: state.phone,
        password: state.password.copyWith(text: text, isValid: isValid),
        confirmPassword: state.confirmPassword.copyWith(isValid: confirmPasswordValid),
      ),
    ));
  }

  void onConfirmPasswordChanged(String text) {
    final isValid = _confirmPasswordValidator(text, state.password.text);
    emit(state.copyWith(
      confirmPassword: state.confirmPassword.copyWith(text: text, isValid: isValid),
      isFormValid: _validateForm(
        name: state.name,
        email: state.email,
        phone: state.phone,
        password: state.password,
        confirmPassword: state.confirmPassword.copyWith(text: text, isValid: isValid),
      ),
    ));
  }

  void onNameFocusChanged(bool isFocused) {
    emit(state.copyWith(name: state.name.copyWith(isFocused: isFocused, isTouched: !isFocused ? true : state.name.isTouched)));
  }
  void onEmailFocusChanged(bool isFocused) {
    emit(state.copyWith(email: state.email.copyWith(isFocused: isFocused, isTouched: !isFocused ? true : state.email.isTouched)));
  }
  void onPhoneFocusChanged(bool isFocused) {
    emit(state.copyWith(phone: state.phone.copyWith(isFocused: isFocused, isTouched: !isFocused ? true : state.phone.isTouched)));
  }
  void onPasswordFocusChanged(bool isFocused) {
    emit(state.copyWith(password: state.password.copyWith(isFocused: isFocused, isTouched: !isFocused ? true : state.password.isTouched)));
  }
  void onConfirmPasswordFocusChanged(bool isFocused) {
    emit(state.copyWith(confirmPassword: state.confirmPassword.copyWith(isFocused: isFocused, isTouched: !isFocused ? true : state.confirmPassword.isTouched)));
  }

  void onTermsAcceptedChanged(bool value) {
    emit(state.copyWith(isTermsAccepted: value));
  }

  bool _validateForm({
    required SignupFormFieldState name,
    required SignupFormFieldState email,
    required SignupFormFieldState phone,
    required SignupFormFieldState password,
    required SignupFormFieldState confirmPassword,
  }) {
    return name.isValid && email.isValid && phone.isValid && password.isValid && confirmPassword.isValid;
  }

  Future<bool> register({
    required BuildContext context,
  }) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration.zero);
    final result = await authRepository.register(
      email: state.email.text,
      password: state.password.text,
      confirmPassword: state.confirmPassword.text,
      name: state.name.text,
      phone: state.phone.text,
    );
    emit(state.copyWith(isLoading: false));
    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Please check your details.')),
      );
    }
    return result;
  }
}
