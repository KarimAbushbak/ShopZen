import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopzen/core/storage/local/datatbase/app_settings_shared_preferences.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AppSettingsSharedPreferences _prefs = AppSettingsSharedPreferences();

  AccountCubit() : super(AccountLoading());

  Future<void> loadData() async {
    final name = _prefs.userName;
    final email = _prefs.userEmail;
    final phone = _prefs.phoneNumber;
    final gender = _prefs.gender;
    final dateOfBirth = _prefs.dateOfBirth;
    emit(
      AccountLoaded(
        name: name,
        email: email,
        dateOfBirth: dateOfBirth,
        gender: gender,
        phoneNumber: phone,
      ),
    );
  }

  Future<void> updateUserInfo({
    String? name,
    String? phone,
    String? gender,
    String? dateOfBirth,
  }) async {
    if (name != null) await _prefs.setUserName(name);
    if (phone != null) await _prefs.setPhone(phone);
    if (gender != null) await _prefs.setGender(gender);
    if (dateOfBirth != null) await _prefs.setDateOfBirth(dateOfBirth);

    emit(
      AccountLoaded(
        name: _prefs.userName,
        email: _prefs.userEmail,
        phoneNumber: _prefs.phoneNumber,
        gender: _prefs.gender,
        dateOfBirth: _prefs.dateOfBirth,
      ),
    );
  }
}
