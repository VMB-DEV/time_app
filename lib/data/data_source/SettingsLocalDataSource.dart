import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_app/core/constants/SharedPreferencesKey.dart';
import 'package:time_app/data/models/SettingsModel.dart';
import 'package:time_app/domain/entities/Settings.dart';
import 'dart:convert';

abstract class SettingsLocalDataSource {
  Future<SettingsModel> getSettings();
  Future<void> updateSettings(SettingsModel settingsModel);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<SettingsModel> getSettings() async {
    String? jsonString = sharedPreferences.getString(SharedPreferencesKey.settings);
    if (jsonString == null) {
      // return null;
      return SettingsModel.from(Settings.defaultState());
    } else {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      SettingsModel settingsModel = SettingsModel.fromJson(jsonMap);
      return settingsModel;
    }
  }

  @override
  Future<void> updateSettings(SettingsModel settingsModel) async {
    final String jsonString = json.encode(settingsModel.toJson());
    sharedPreferences.setString(SharedPreferencesKey.settings, jsonString);
  }
}