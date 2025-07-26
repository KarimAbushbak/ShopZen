part of 'account_cubit.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountLoaded extends AccountState {
  final String name;
  final String email;
  final String dateOfBirth;
  final String gender;
  final String phoneNumber;

  AccountLoaded({
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
  });
}
