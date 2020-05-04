import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

const _language = 'language';
const _currency = 'currency';
const _tokenLoggedIn = 'token_logged_in';
const _tokenWaitingFor2FA = 'token_waiting_for_2fa';
const _tokenResetPasswordVerifying = 'token_reset_password_verifying';
const _gesturePassword = 'gesture_password';
const _languageCode = 'language_code';
const _countryCode = 'country_code';
const _chartTimeIntervalValue = 'chart_time_interval_value';
const _instrumentId = 'instrument_id';
const _chartIndicatorMaState = 'chart_indicator_ma_state';
const _chartIndicatorBollState = 'chart_indicator_boll_state';

class Settings {
  ///
  static final Settings _singleton = Settings._internal();

  factory Settings() => _singleton;

  ///
  Future<bool> init() async {
    return true;
  }

  Future<bool> getChartIndicatorBollState() async {
    final state = await _getBool(_chartIndicatorBollState);
    return state ?? false;
  }

  Future<bool> setChartIndicatorBollState(bool state) async {
    return _setBool(_chartIndicatorBollState, state);
  }

  Future<bool> getChartIndicatorMaState() async {
    final state = await _getBool(_chartIndicatorMaState);
    return state ?? false;
  }

  Future<bool> setChartIndicatorMaState(bool state) async {
    return _setBool(_chartIndicatorMaState, state);
  }

  Future<String> getInstrumentId() async {
    var id = await _getString(_instrumentId);
    if (id == null || id.isEmpty) {
      id = defaultInstrumentId;
    }
    return id;
  }

  Future<bool> setInstrumentId(String code) async {
    return _setString(_instrumentId, code);
  }

  Future<String> getChartTimeIntervalValue() async {
    return _getString(_chartTimeIntervalValue);
  }

  Future<bool> setChartTimeIntervalValue(String code) async {
    return _setString(_chartTimeIntervalValue, code);
  }

  Future<String> getCountryCode() async {
    return _getString(_countryCode);
  }

  Future<bool> setCountryCode(String code) async {
    return _setString(_countryCode, code);
  }

  Future<String> getLanguageCode() async {
    return _getString(_languageCode);
  }

  Future<bool> setLanguageCode(String code) async {
    return _setString(_languageCode, code);
  }

  Future<String> getGesturePassword() async {
    return _getString(_gesturePassword);
  }

  Future<bool> setGesturePassword(String pattern) async {
    return _setString(_gesturePassword, pattern);
  }

  Future<bool> setTokenWaitingFor2FA(String token) async {
    return _setString(_tokenWaitingFor2FA, token);
  }

  Future<String> getTokenWaitingFor2FA() async {
    return _getString(_tokenWaitingFor2FA);
  }

  Future<bool> setTokenResetPasswordVerifying(String token) async {
    return _setString(_tokenResetPasswordVerifying, token);
  }

  Future<String> getTokenResetPasswordVerifying() async {
    return _getString(_tokenResetPasswordVerifying);
  }

  Future<bool> setTokenLoggedIn(String token) async {
    return _setString(_tokenLoggedIn, token);
  }

  Future<String> getTokenLoggedIn() async {
    return _getString(_tokenLoggedIn);
  }

  Future<bool> setLanguage(String username) async {
    return _setString(_language, username);
  }

  Future<String> getLanguage() async {
    return _getString(_language);
  }

  Future<bool> setCurrency(String currency) async {
    return _setString(_currency, currency);
  }

  Future<String> getCurrency() async {
    return _getString(_currency);
  }

  //
  Settings._internal();

  Future<bool> _enable(String key) async {
    return (await _prefs()).setBool(key, true);
  }

  Future<bool> _disable(String key) async {
    return (await _prefs()).setBool(key, false);
  }

  Future<bool> _isEnabled(String key) async {
    return (await _prefs()).getBool(key);
  }

  Future<int> _getInt(String key) async {
    return (await _prefs()).getInt(key);
  }

  Future<bool> _setInt(String key, int value) async {
    return (await _prefs()).setInt(key, value);
  }

  Future<String> _getString(String key) async {
    return (await _prefs()).getString(key);
  }

  Future<bool> _setString(String key, String value) async {
    return (await _prefs()).setString(key, value);
  }

  Future<bool> _getBool(String key) async {
    return (await _prefs()).getBool(key);
  }

  Future<bool> _setBool(String key, bool value) async {
    return (await _prefs()).setBool(key, value);
  }

  Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }
}
