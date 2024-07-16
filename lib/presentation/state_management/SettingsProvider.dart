import 'package:flutter/material.dart';
import 'package:time_app/domain/entities/Settings.dart';
import 'package:time_app/domain/usecases/settings/GetSettings.dart';
import 'package:time_app/domain/usecases/settings/UpdateSettings.dart';

class SettingsProvider with ChangeNotifier {
  final GetSettingsUseCase getSettingsUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;

  Settings? _settings;

  SettingsProvider({
    required this.getSettingsUseCase,
    required this.updateSettingsUseCase,
    // required this.updateDarkThemeStateUseCase,
    // required this.updateAmPmFormatStateUseCase,
  });

  Settings get settings => _settings ?? Settings.defaultState();

  Future<void> loadSettings() async {
    _settings = await getSettingsUseCase.execute();
    notifyListeners();
  }

  Future<void> updateSettings(Settings newSettings) async {
    await updateSettingsUseCase.execute(newSettings);
    _settings = newSettings;
    notifyListeners();
  }

  Future<void> updateDarkThemeTo(bool newState) async {
    Settings newSettings = Settings(darkTheme: newState, amPmFormat: settings.amPmFormat, firstLaunch: settings.firstLaunch);
    updateSettings(newSettings);
  }

  Future<void> updateAmPmFormat(bool newState) async {
    Settings newSettings = Settings(darkTheme: settings.darkTheme, amPmFormat: newState, firstLaunch: settings.firstLaunch);
    updateSettings(newSettings);
  }
}