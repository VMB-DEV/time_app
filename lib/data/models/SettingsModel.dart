import 'package:flutter/foundation.dart';
import 'package:time_app/domain/entities/Settings.dart';

class SettingsModel extends Settings {
  SettingsModel({
    required super.darkTheme,
    required super.amPmFormat,
    required super.firstLaunch
  });


  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
        darkTheme: json['darkTheme'],
        amPmFormat: json['amPmFormat'],
        firstLaunch: json['firstLaunch'],
    );
  }

  factory SettingsModel.from(Settings settings) {
    return SettingsModel(
      darkTheme: settings.darkTheme,
      amPmFormat: settings.amPmFormat,
      firstLaunch: settings.firstLaunch,
    );
  }

  factory SettingsModel.defaultState() => SettingsModel.from(Settings.defaultState());

  Map<String, dynamic> toJson() {
    return {
      'darkTheme': darkTheme,
      'amPmFormat': amPmFormat,
      'firstLaunch': firstLaunch,
    };
  }
}