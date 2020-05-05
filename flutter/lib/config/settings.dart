import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

const _surveyComplete = 'survey_complete';

class Settings {
  ///
  static final Settings _singleton = Settings._internal();

  factory Settings() => _singleton;

  ///
  Future<bool> init() async {
    return true;
  }

  Future<bool> getSurveyComplete() async {
    final state = await _getBool(_surveyComplete);
    return state ?? false;
  }

  Future<bool> setSurveyComplete(bool state) async {
    return _setBool(_surveyComplete, state);
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
